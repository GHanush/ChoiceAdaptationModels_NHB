function launch_task

isubject = 131; 
scriptFolder = fileparts(mfilename('fullpath'));
dataFile = fullfile(scriptFolder, '..', 'data_dom2val.mat');
load(dataFile);
tmp = data.subject(isubject);    
save('tmp.mat','tmp')


ima(isubject);
% dist(isubject);
% opt(isubject);
% rl(isubject);



end




