function est = rl(isubject)

% Free parameters value intervals
alpha_int = [0,1];   % RL rate  
fy_int    = [0,1];   % proposed vs. rl value   
ps_int    = [0,0.1]; % lapse rate  
beta_int  = [0,70];  % inverse temperature

% Lower and upper bounds of free parameters in each of four condition
pars_lower = [alpha_int(1),fy_int(1),ps_int(1),beta_int(1)];
pars_upper = [alpha_int(2),fy_int(2),ps_int(2),beta_int(2)];
% Lower and upper bounds of free parameters 
lower =  [repmat(pars_lower,1,4)];
upper =  [repmat(pars_upper,1,4)];

%%
% Configuring the optimization

subj = isubject;
for x = 1:length(subj)

        % Randomly choosing one value per parameter for slice sampling
        x0 = lower + (upper-lower).*rand(1,length(lower));
        % Choosing initial par values (through slice sampling) for fitting
        parint = slice_sampling(x0,lower,upper);
        
        % Settings for optimization
        options = optimoptions(@fmincon,'MaxIterations',2000,'MaxFunctionEvaluations',20000);
        Aineq = []; bineq = []; Aeq = [];beq = []; nonlcon = [];

        % Initializing a matrix for storing 3000 optimization outputs
        sample = zeros(3000,length(lower)+2);
       
        % Optimizing and storing
        parfor smp = 1:size(sample,1)                    
            [bestP,bestLLH,exitflag] = fmincon(@ModelLLH_rl_domval,parint(smp,:),Aineq,bineq,Aeq,beq,lower,upper,nonlcon,options);           
            sample(smp,:) = [bestP,bestLLH,exitflag];         
        end       
         
        % Second round of optimization (starting from optimized values) and storing 
        parint = sample(:,1:end-2);
        parfor smp = 1:size(sample,1)                  
            [bestP,bestLLH,exitflag] = fmincon(@ModelLLH_rl_domval,parint(smp,:),Aineq,bineq,Aeq,beq,lower,upper,nonlcon,options);           
            sample(smp,:) = [bestP,bestLLH,exitflag];         
        end    
        
        % Storing and saving the output
        learning_rl_domval.subject(subj).sample = sample;        
        sample = []; 
end

        save ('learning_rl_domval.mat','learning_rl_domval')  
        est =  learning_rl_domval;


end



