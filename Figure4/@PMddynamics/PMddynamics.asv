classdef PMddynamics < handle
    %
    %
    %
    %
    %
    properties

        rtFR;

        signalplusnoise
        perCoh
        signalerror
        noise
        project
        excursion


        distance

        kinet

        metaData;
        trialCounts

        processingFlags;
    end

    methods

        function [r, temp] = PMddynamics(M, varargin)

            useSingleNeurons = false;
            useNonOverlapping = false;
            assignopts(who, varargin)
            r.initializeProcessingFlags(useSingleNeurons, useNonOverlapping);
            r.initializeMetaData(M);

            if isfield(M.rt,'TrialCounts')
                r.trialCounts = M.rt.TrialCounts;
            end

            r.rtFR = M.rt.FR;



            [r.signalplusnoise] = r.calculatePCs(M.rt.FR(:,:,r.metaData.neuronIdx,:));
            [r.noise] = r.calculatePCs(M.rt.FRnoise(:,:,r.metaData.neuronIdx,:));
            %  [r.project] = r.calculatePCs(M.rt.FR(:,:,r.metaData.neuronIdx,:),'outSpace',M.rt.outSpace,'projectToOutcome','true');



            whichDim = 1:6;

            fprintf('\n------');
            for p=1:size(M.rt.bsFR,4)
                cprintf('yellow',sprintf('\n Bootstrap: %d', p));
                [temp] = r.calculatePCs(permute(squeeze(M.rt.bsFR(r.metaData.neuronIdx,:,:,p,:)),[2 3 1 4]));

                r.signalerror.varExplained(p,:) = temp.varExplained;


                kinetV = r.calcSpeed(temp);
                r.kinet.V(p,:,:) = kinetV.V;
                r.kinet.tVect = kinetV.tVect;
                r.kinet.distancesAll(p,:,:) = kinetV.distancesAll;
                r.kinet.speed(p,:,:) = kinetV.speed;
                r.kinet.tSpeed = kinetV.tSpeed;


                r.kinet.spaceAngle(p,:) = kinetV.addData.spaceAngle;
                r.kinet.meanVectorAngle(p,:) = kinetV.addData.meanVectorAngle;

                for z=1:length(temp.TrajIn)
                    r.distance(z).V(p,:) = sqrt(sum([temp.TrajIn{z}(:,whichDim) - temp.TrajOut{z}(:,whichDim)].^2,2));
                end


            end

            r.calculateExcursion(M)
        end

        % Calculation functions
        calcKinetStatistics(r)
        reportKinetStats(r)
        dataV = calcSpeed(r, PCoutput, varargin)
        PCoutput = calculatePCs(r,FR, varargin)
        temp = calculatePCsfromEachBS(r,FR, varargin);



        % Plotting functions
        dataTable = plotKinet(r)
        dataTable = plotTrajectories(r,varargin)
        dataTable = plotVariance(r, varargin)
        dataTable = plotComponents(r, varargin)
        dataTable = plotTrialCounts(r)
        [slopeV, bV, cohValues,  forBigCorr,  metaData, dataTable] = calcInputsAndIC(r, varargin)

        function plotKinetAverage(r)

            currKinet = r.kinet.V;


        end

        function calculateExcursion(r,M)
            tS = M.rt.tS;getParams
            tM = M.rt.tM;

            tSix = tS > -0.2 & tS < -0.1;
            tMix = tM > -0.2 & tM < 0.1;

            distV1 = nanmean(M.rt.bsFR(:,:,:,:,tSix),5);
            distV2 = nanmean(M.rt.bsFRm(:,:,:,:,tMix),5);

            K = nanmean(nansum(abs(distV1 - distV2),1),3);
            r.excursion = squeeze(K);
        end

        function plotExcursion(r)

            params = getParams;
            RTl = params.RTpcL(1:11)
            RTh = params.RTpcH(1:11)

            errorbar([RTl + RTh]/2,nanmean(r.excursion,2),nanstd(r.excursion,[],2),'ko-','markerfacecolor',[0.4 0.4 0.4],'markersize',12);
            hold on
        end



        function initializeMetaData(r, M)
            params = getParams;
            r.metaData.condColors = params.posterColors;
            r.metaData.RTlims = M.rt.RTlims;
            r.metaData.tMin = -0.4;
            if r.processingFlags.useNonOverlapping
                cprintf('blue','using non overlapping bins \n');
                r.metaData.whichConds = [1 13 11];
            else
                r.metaData.whichConds = [1:11];
            end

            cIds = ceil(linspace(1,size(params.posterColors,1),length(r.metaData.whichConds)));
            r.metaData.selColors = r.metaData.condColors(cIds,:);
            r.metaData.t = M.rt.tS;
            r.metaData.nComponents = 20;
            r.metaData.nDims = 6;
            r.metaData.removeTime = 25;
            r.metaData.tMax = 0;
            r.metaData.kinetTimePt = 20;
            r.metaData.dt = 10;
            r.metaData.camPosition = [485.6722 -650.3079 104.7287];
            r.metaData.dimsToShow = [1 2 4];

            if r.processingFlags.useSingleUnits
                cprintf('magenta','using Single Neurons');
                tibs = load('TibsISI.mat');
                olaf = load('OlafISI.mat');
                allISI = [olaf.allISI; tibs.allISI];
                r.metaData.neuronIdx = allISI(:,3) <=0.015;
            else
                cprintf('magenta','using all units \n ----------------------------------------------------------- \n');
                r.metaData.neuronIdx = 1:length(M.rt.NeuronIds);


            end


        end

        function kinetBarPlot(r, varargin)


            whichVar = 'speed';

            assignopts(who, varargin);

            figure;

            switch(whichVar)
                case 'speed'
                    R = r.kinet.V(:,r.kinet.tVect < abs(r.metaData.tMin),:);

                    ylims = [-100 100];
                    yticks = [-100:50:100];

                    multiplier = 1000;
                case 'distance'
                    R = r.kinet.distancesAll(:, r.kinet.tVect < abs(r.metaData.tMin),:);
                    multiplier = 1;
                    ylims = [-20 20];
                    yticks = [-20:10:20];
            end

            middleCond = ceil(size(R,3)/2);
            nConds = size(R,3);
            ref = R(:,:,middleCond);
            R = R - repmat(ref, [1 1 size(R,3)]);
            R = squeeze(nanmean(R,2))*multiplier;



            colValues = r.metaData.selColors;
            RTv = r.metaData.RTlims(:, r.metaData.whichConds);
            RTv = nanmean(RTv);

            for n=1:nConds
                tt(n) = bar(n, nanmean(R(:,n)),'FaceColor',colValues(n,:));
                hold on;
                tLabel{n} = sprintf('%3.0f',RTv(n));
                tLabelColor{n} = 'b';
                tickV(n) = n;
            end

            set(tt,'linestyle','none', 'ShowBaseline','off');
            hold on;

            errorbar(1:nConds, nanmean(R), 2*nanstd(R),'linestyle','none');
            set(gca,'visible','off');


            tLab = getTextLabel(tickV, tLabel, tLabelColor);

            getAxesP([1 nConds],[ ],10,ylims(1)-3,'RT bin (ms)',ylims,yticks,1,0,'Time To Reference (ms)',[1 1], tLab);
            axis square;
            axis tight;



        end


        function initializeProcessingFlags(r, useSingleUnits, useNonOverlapping)
            r.processingFlags.subtractCCmean = false;
            r.processingFlags.meanSubtract = false;
            r.processingFlags.useSingleUnits = useSingleUnits;
            r.processingFlags.zScore = false;
            r.processingFlags.useNonOverlapping = useNonOverlapping;
            r.processingFlags.tColor = 'blue';
        end



        function assignColors(r, colorMatrix)
            r.metaData.condColors = colorMatrix;

        end

        function plotColors(r)

            set(gcf,'color',[1 1 1]);
            for k=1:size(r.metaData.condColors,1)
                plot(k*ones(1,10),1:10,'color',r.metaData.condColors(k,:),'linewidth',8);
                hold on;
            end
            set(gca,'visible','off');

        end


        function [r]=calcWinCoh(r, M, varargin)
            nDims = 6;
            assignopts(who, varargin);
            for coh= 1:7
                [r.perCoh(coh).pcaData] = r.calculatePCs(permute(squeeze(M.rt.AllFR(r.metaData.neuronIdx,coh,:,:,:)),[2 3 1 4]),'removeTime',25, 'projectFromMean', true, 'nDims', nDims);
            end

        end

        %     function [r]=calcSubProj(r,varargin)
        %             numComps=6;
        %             assignopts(who,varargin)
        %
        %             eV = OutPCA_eigenVs(:,1:numComps);
        %             C=r.signalplusnoise.covMatrix;
        %             R = trace(eV'*C*eV);
        %             sumLatent=sum(r.signalplusnoise.latentActual);
        %             r.signalplusnoise.varExplainedbyproj =  R/sumLatent;
        %         end


    end

end
