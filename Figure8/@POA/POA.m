classdef POA < handle
    %
    %
    %
    %
    %
    properties

        % data
        signalplusnoise
        distance
        kinet
        decode
        noise
        project


        % parameters
        metaData;
        processingFlags;

    end

    methods

        function [r] = POA(outcome,varargin)

            % change analyses
            useSingleNeurons = false;
            trials ='CC_EC'; % 'trials', 'CCE_ECC'
            iterSize=size(outcome.outcomePCA_trunc_Boot,5);
            iterSizeM = size(outcome.PCAm.outcomePCAm_trunc_Boot,5);
            assignopts(who, varargin);

            %initialize parameters
            r.initializeProcessingFlags(useSingleNeurons);
            r.initializeMetaData();


            % initialize RT metadata for CCEC or CCE_ECC
            if strcmp(trials, 'CC_EC')
                r.metaData.RT1=vertcat(outcome.errInd.PES_CCEC_RT{:});
                r.metaData.RT2=vertcat(r.metaData.RT1{:});
                r.metaData.RTlims = median(r.metaData.RT2);
            else
                for sess =1:length(outcome.CCE_ECC.trials)
                    for st= 1:length(outcome.CCE_ECC.trials{sess,1})
                        r.metaData.RT0{sess,1}{st,1}=outcome.b{sess,1}{st,1}(outcome.CCE_ECC.trials{sess,1}{st,1});
                    end
                end
                r.metaData.RT1=vertcat(r.metaData.RT0{:});
                r.metaData.RT2=vertcat(r.metaData.RT1{:});
                r.metaData.RTlims = median(r.metaData.RT2);
            end

            % calculate PCs to plot for components and trajectories - CC_EC
            % or CCE_ECC
            if strcmp(trials, 'CC_EC')
                PCAoutcome=outcome.outcomePCA_trunc(:,r.metaData.neuronIdx,:,:);
            else
                PCAoutcome=outcome.CCE_ECC.outcomePCA_trunc(:,r.metaData.neuronIdx,:,:);
            end
            [r.signalplusnoise] = r.calculatePCs(permute(PCAoutcome, [3 4 2 1]));

            % calculate Euclidean distance between left and right trajs
            whichDim = 1:r.metaData.nDims;
            TrajIn = r.signalplusnoise.TrajIn;
            TrajOut = r.signalplusnoise.TrajOut;
            for z=1:length(TrajIn)
                r.distance(z).V = [sqrt(sum([TrajIn{z}(:,whichDim) - TrajOut{z}(:,whichDim)].^2,2))]';
            end

            % calculate KiNeT velocity and distance from trajectories
            r.kinet=r.calcSpeed(r.signalplusnoise,'nDimensions',6);

            % Calculating SEM for bootstraped KiNeT - CC_EC
            % or CCE_ECC
            if strcmp(trials, 'CC_EC')
                PCAoutcome_Boot=outcome.outcomePCA_trunc_Boot;
            else
                PCAoutcome_Boot=outcome.CCE_ECC.outcomePCA_trunc_Boot;
            end

            for iter = 1: iterSize
                pcData = r.calculatePCs(permute(PCAoutcome_Boot(:,:,:,:,iter), [3 4 2 1]));
                dataV = r.calcSpeed(pcData);
                r.kinet.BootV(:,:,iter)=dataV.V;
                r.kinet.BootDist(:,:,iter)=dataV.distancesAll;
            end

            % Shuffles for CCE_ECC
        if strcmp(trials, 'CCE_ECC')
            for iter = 1: size(outcome.CCE_ECC.outcomePCA_trunc_Shuf,5)
                pcData = r.calculatePCs(permute(outcome.CCE_ECC.outcomePCA_trunc_Shuf(:,:,:,:,iter), [3 4 2 1]));
                dataV = r.calcSpeed(pcData);
                r.kinet.shuffV(:,:,iter)=dataV.V;
                r.kinet.shuffDist(:,:,iter)=dataV.distancesAll;
            end
        else
            % do nothing
        end

            % prepare data for decoding analysis
            r.decode=outcome.decode;

            % noise PCA
            r.noise.varExplained = outcome.noise.varExplained;

            % movement-aligned Euclidean distance calculation with 95% CI
            [r.signalplusnoise.moveAlign] = r.calculatePCs(permute(outcome.PCAm.outcomePCAm_trunc, [3 4 2 1]),'moveAlign',1);
            TrajIn = r.signalplusnoise.moveAlign.TrajIn;
            TrajOut = r.signalplusnoise.moveAlign.TrajOut;
            for z=1:length(TrajIn)
                r.distance(z).moveAlign = [sqrt(sum([TrajIn{z}(:,whichDim) - TrajOut{z}(:,whichDim)].^2,2))]';
            end
            
         % for calculating the 95% CI for movement-aligned Euclidean dist.
            for iter = 1: iterSizeM 
                pcData = r.calculatePCs(permute(outcome.PCAm.outcomePCAm_trunc_Boot(:,:,:,:,iter), [3 4 2 1]),'moveAlign',1);
                TrajIn = pcData.TrajIn;
                TrajOut = pcData.TrajOut;
                for z=1:length(TrajIn)
                    r.distance(z).moveAlign_Boot(:,:,iter) = [sqrt(sum([TrajIn{z}(:,whichDim) - TrajOut{z}(:,whichDim)].^2,2))]';
                end
            end

         % for calculating subspace projection 
        [r.project] = r.calculatePCs(permute(outcome.outcomePCA_trunc, [3 4 2 1]),'projectFromMean',true,'RTspace',outcome.projRT.RTPCAeigenVs,'RTcov',outcome.projRT.RTcovMatrix,'RTlatents',outcome.projRT.RTlatents);



         end
% 
        %Outside functions
        [pcData] = calculatePCs(r,FR,varargin);
        [CI,meanDist]=plotComponents(r,varargin);
        plotTrajectories(r, varargin);
        plotKinet(r);
        dataV = calcSpeed(r,temp, varargin);
        calcDecode(r,outcome);
        plotDecoder(r);
        plotVariance(r,varargin);
        plotBiplot(r);


        function initializeProcessingFlags(r, useSingleUnits)

            r.processingFlags.subtractCCmean = false;
            r.processingFlags.meanSubtract = true;
            r.processingFlags.useSingleUnits = useSingleUnits;
            r.processingFlags.zScore = false;
            r.processingFlags.tColor = 'blue';

        end


        function initializeMetaData(r)

            params = getParams; set(gcf,'visible','off');
            r.metaData.condColors = [0 1 0; 0 1 1; 1 0 0; 1 0 1];
            r.metaData.tMin = -0.4;
            r.metaData.whichConds = [1:4];
            r.metaData.t = linspace(-.6,1.2,1801);
            r.metaData.t_move = linspace(-.9,.9,1801);
            r.metaData.nComponents = 20;
            r.metaData.removeTime = 25;
            r.metaData.tMax = 0;
            r.metaData.OSess= [8 19 20 21 25 28 31 33 35 36 38 39 40:45 47:51 56 57 58 65]';
            r.metaData.TSess= [118:141]';
            r.metaData.sessions51=[r.metaData.OSess; r.metaData.TSess];
            r.metaData.nDims = 6;

            if r.processingFlags.useSingleUnits
                cprintf('magenta','using Single Neurons');
                tibs = load('TibsISI');
                olaf = load('OlafISI');
                allISI = [olaf.allISI; tibs.allISI];
                r.metaData.neuronIdx = allISI(:,3) <=0.015;
            else
                cprintf('magenta','using all units \n ----------------------------------------------------------- \n');
                r.metaData.neuronIdx = 1:996;
            end





        end


    end
end


