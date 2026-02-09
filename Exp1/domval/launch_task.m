function launch_task
% Step 1. change to ID of any participant in Experiment 1
isubject = 131; 
scriptFolder = fileparts(mfilename('fullpath'));
dataFile = fullfile(scriptFolder, '..', 'data_dom2val.mat');
load(dataFile);
tmp = data.subject(isubject);    
save('tmp.mat','tmp')

% Step 2. choose models to run fitting by commenting out unchosen models
ima(isubject);
% dist(isubject);
% opt(isubject);
% rl(isubject);

% Step 3. save changes in steps 1 and 2
% Step 4. type 'launch_task' in the command window


end

