function [parint] = slice_sampling(x0,lower,upper)

sample_num = 3000; % 100000
paralt = zeros(sample_num,length(lower)); % alternative parameter sets' stock

parfor i = 1:length(lower)
f = @(x) unifpdf(x,lower(i),upper(i));
paralt(:,i) = slicesample(x0(i),sample_num,'pdf',f,'thin',10,'burnin',20000); % 2 - 15000
end







% LLHalt = zeros(1,sample_num);
% 
% parfor j = 1:sample_num
%     LLHalt(j) = ModelLLH_mix_domval_common(paralt(j,:)); 
%     
% end

% [minLLH,indLLH] = min(LLHalt);
% parint = paralt(indLLH,:);

parint = paralt;

end






