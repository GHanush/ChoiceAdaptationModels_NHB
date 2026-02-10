function [parint] = slice_sampling(x0,lower,upper)

sample_num = 10; % 100000, 3000
paralt = zeros(sample_num,length(lower)); % alternative parameter sets' stock

parfor i = 1:length(lower)
f = @(x) unifpdf(x,lower(i),upper(i));
paralt(:,i) = slicesample(x0(i),sample_num,'pdf',f,'thin',5,'burnin',10000); % 2 - 15000
end

parint = paralt;

end








