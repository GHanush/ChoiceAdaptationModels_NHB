function launch_task(isubject)
scriptFolder = fileparts(mfilename('fullpath'));
dataFile = fullfile(scriptFolder, '..', 'data_dom2val.mat');
load(dataFile);
tmp = data.subject(isubject);    
save('tmp.mat','tmp')


mix(isubject);
%   dist(isubject);
%   opt(isubject);

end