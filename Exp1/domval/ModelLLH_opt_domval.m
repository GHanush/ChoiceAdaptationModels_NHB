function [LLH] = ModelLLH_opt_domval(param)
LLH = 0;
sB = [0.5, 0.5];   % initialize state beliefs
r = 0;             % initialize zero-step reward (no impact)
x = 0;             % initalize zero-step  outcome (no impact)
bias = 0;          % reward and reward frequency inter-relation bias

load tmp;

for b = 1:4 % loop over blocks
    if b == 1
        par = [param(1),param(2),param(3),param(4)];
    elseif b == 2
        par = [param(5),param(6),param(7),param(8)];
    elseif b == 3
        par = [param(9),param(10),param(11),param(12)];
    elseif b == 4
        par = [param(13),param(14),param(15),param(16)];
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
        % Retreiving the proposed outcomes
        Figure(1).block(b).session(k).trial(1,:) = bank - cf*tmp.block(b).episode(k).sq_proposed;
        Figure(2).block(b).session(k).trial(1,:) = bank - cf*tmp.block(b).episode(k).rh_proposed;
        % Retreiving the observed outcomes
        Figure(1).block(b).session(k).reward(1,:) = bank - cf*tmp.block(b).episode(k).sq_actual;
        Figure(2).block(b).session(k).reward(1,:) = bank - cf*tmp.block(b).episode(k).rh_actual;
        % Retrieivng the choice
        Response.block(b).session(k).choice(1,:)  = tmp.block(b).episode(k).response;
       
       
        for t = 1:max(tmp.block(b).episode(k).trial) % loop over trials
                                   
           % observe proposed rewards
            vPR(1) = Figure(1).block(b).session(k).trial(t);
            vPR(2) = Figure(2).block(b).session(k).trial(t);
            
           % update initial state beliefs after seeing proposed rewards
            B(1) = exp(bias*(vPR(1) - vPR(2))) * sB(1);
            B(2) = exp(bias*(vPR(2) - vPR(1))) * sB(2);
           % normalize state beliefs
            nB(1) = B(1)/(B(1) + B(2));
            nB(2) = 1 - nB(1);
         
           % compute reward probabilities by marginalizing over beliefs
            P(1) = par(4)*nB(1) + (1 - par(4))*nB(2);
            P(2) = (1 - par(4))*nB(1) + par(4)*nB(2);
                       
           % compute decision variable
            A = diff(vPR.*P);
           % derive reward probability of choices (using sigmoid function)
            Prob(2) = max(realmin,(1 - par(2)) * 1/(1 + exp(-par(3)*A)) + par(2)/2);
            Prob(1) = 1 - Prob(2);
                     
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
       
            
            if a == 0
                tB = P;
                LLH = LLH;
            else

            % update beliefs for the current trial
            I = x*(2-a)+(1-x)*(a-1);
            tB(1) = (par(4)^I)*((1-par(4))^(1 - I))*P(1); 
            tB(2) = ((1-par(4))^I)*(par(4)^(1 - I))*P(2);
            LLH = LLH + log(Prob(a));
            end
            
            % form beliefs for the next trial
            sB(1) = (1 - par(1))*tB(1) + par(1)*tB(2);
            sB(2) = par(1)*tB(1) + (1 - par(1))*tB(2);
                      
        end
end

sB = [0.5, 0.5];   % initialize state beliefs
r = 0;             % initialize zero-step reward (no impact)
x = 0;             % initalize zero-step outcome (no impact)
bias = 0;          % reward and reward frequency inter-relation bias

    
end 
LLH = -LLH;
end