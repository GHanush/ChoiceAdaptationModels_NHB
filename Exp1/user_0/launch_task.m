function launch_task(isubject)
scriptFolder = fileparts(mfilename('fullpath'));
dataFile = fullfile(scriptFolder, '..', 'Exp1', 'data_dom2val.mat');
loadedData = load(dataFile);
tmp = data.subject(isubject);    
save('tmp.mat','tmp')
clear
clc


mix(isubject);
%   dist(isubject);
%   opt(isubject);

end