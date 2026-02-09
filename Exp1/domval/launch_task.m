function launch_task
% Step 1. change the value of variable 'isubject' to ID of any participant in Experiment 1
% Step 2. choose models to run the fitting by commenting out unchosen models
% Step 3. save changes in steps 1 and 2
% Step 4. type 'launch_task' in the command window


isubject = 131; 
ima(isubject);
% dist(isubject);
% opt(isubject);
% rl(isubject);

scriptFolder = fileparts(mfilename('fullpath'));
dataFile = fullfile(scriptFolder, '..', 'data_dom2val.mat');
load(dataFile);
tmp = data.subject(isubject);    
save('tmp.mat','tmp')

end


