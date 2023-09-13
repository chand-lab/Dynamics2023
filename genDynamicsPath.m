function genDynamicsPath()
dynDir=dir;
names=string({dynDir(vertcat(dynDir.isdir)).name}');
dynFolders=names(5:end);

for i =1:length(dynFolders)
addpath(genpath(dynFolders(i)))
end

end