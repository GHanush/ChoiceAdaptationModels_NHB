function [LLH] = ModelLLH_mixfull_domval(param)
LLH = 0;           
sB = [0.5, 0.5];   % initialize beliefs
vRL_old = [50,50]; % initialize  RL values of bandits
r = 0;             % initialize zero-step reward (no impact)
x = 0;             % initalize zero-step  outcome (no impact)
a_old = 0;         % make zero-step choice randomly (no impact)
bias = 0;          % reward and reward frequency inter-relation bias

load tmp;

for b = 1:4 % loop over blocks
    if b == 1
        par = [param(1),param(2),param(3),param(4),param(5),param(6),param(7)];
    elseif b == 2
        par = [param(8),param(9),param(10),param(11),param(12),param(13),param(14)];
    elseif b == 3
        par = [param(15),param(16),param(17),param(18),param(19),param(20),param(21)];
    elseif b == 4
        par = [param(22),param(23),param(24),param(25),param(26),param(27),param(28)];
    end
        

% The current block is in gain or loss domain
if tmp.block(b).episode(1).outcome(1) ==...
        tmp.block(b).episode(1).gain(1)
    
    bank = 0; % no endowement in gain condition
    cf = -1;  % outcome = gain
else
    
    bank = 100; % endowement in loss condition
    cf = 1;     % outcome = endowement - loss
end


for k = 1:length(tmp.block(b).episode) % loop over episodes
        % Retreiving the proposed outcome
        Figure(1).block(b).session(k).trial(1,:) = bank - cf*tmp.block(b).episode(k).sq_proposed;
        Figure(2).block(b).session(k).trial(1,:) = bank - cf*tmp.block(b).episode(k).rh_proposed;
        % Retreiving the observed outcome
        Figure(1).block(b).session(k).reward(1,:) = bank - cf*tmp.block(b).episode(k).sq_actual;
        Figure(2).block(b).session(k).reward(1,:) = bank - cf*tmp.block(b).episode(k).rh_actual;
        % Retrieivng the choice
        Response.block(b).session(k).choice(1,:)  = tmp.block(b).episode(k).response;
       
        for t = 1:max(tmp.block(b).episode(k).trial) % loop over trials
            
            if a_old == 0
               vRL = vRL_old;
            else          
           % update RL values for the current trial
            vRL(a_old) = vRL_old(a_old) + par(2)*(r - vRL_old(a_old));
            vRL(3-a_old) = vRL_old(3-a_old);
            end
                         
           % observe proposed rewards
            vPR(1) = Figure(1).block(b).session(k).trial(t);
            vPR(2) = Figure(2).block(b).session(k).trial(t);
            
           % update initial state beliefs after seeing proposed rewards
            B(1) = exp(bias*(vPR(1) - vPR(2))) * sB(1);
            B(2) = exp(bias*(vPR(2) - vPR(1))) * sB(2);
            
           % normalize state beliefs
            nB(1) = B(1)/(B(1) + B(2));
            nB(2) = 1 - B(1);
                     
           % compute affective values
            v = (par(3)*vPR + (1-par(3))*vRL)/sum(par(3)*vPR + (1-par(3))*vRL);
           % combine affective values and state beliefs (compute decision variable)
            A = (1 - par(4))*(v(1) - v(2)) + par(4)*(nB(1) - nB(2));
                       
           % derive reward probability of choices (using softmax rule)
            Prob(1) = max(realmin,(1 - par(5)) * 1/(1 + exp(-par(6)*A)) + par(5)/2);
            Prob(2) = 1 - Prob(1);
                     
            % choice, reward and feedback in the current trial
            if Response.block(b).session(k).choice(t) == 4
               a = 1;
               r = Figure(a).block(b).session(k).reward(1,t);
            elseif Response.block(b).session(k).choice(t) == 8
               a = 2;
               r = Figure(a).block(b).session(k).reward(1,t);
            else
               a = 0; 
               r = 0;
            end
            
            
            if r == 0
                x = 0;
            else
                x = 1;
            end          
            
            % archive RL values of the current trial
            vRL_old = vRL;
            a_old = a;
            
            if a == 0
                tB = nB;
                LLH = LLH;
            else
            % update beliefs for the current trial
            I = x*(2-a)+(1-x)*(a-1);
            tB(1) = (par(7)^I)*((1-par(7))^(1 - I))*nB(1); 
            tB(2) = ((1-par(7))^I)*(par(7)^(1 - I))*nB(2);
            LLH = LLH + log(Prob(a));
            end
            
            % form beliefs for the next trial
            sB(1) = (1 - par(1))*tB(1) + par(1)*tB(2);
            sB(2) = par(1)*tB(1) + (1 - par(1))*tB(2);
            
           
        end
         
        
end

% Starting a new block
sB = [0.5, 0.5];   % initialize beliefs
vRL_old = [50,50]; % initialize  RL values of bandits
r = 0;             % initialize zero-step reward (no impact)
x = 0;             % initalize zero-step outcome (no impact)
a_old = 0;         % make zero-step choice randomly (no impact)
bias = 0;          % reward and reward frequency inter-relation bias
   
end
LLH = -LLH;

end
