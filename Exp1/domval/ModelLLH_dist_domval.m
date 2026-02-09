function [LLH] = ModelLLH_dist_domval(param)
LLH = 0;
sB = [0.5, 0.5]; % initialize state beliefs
r = 0;             % initialize zero-step reward (no impact)
x = 0;             % initalize zero-step  outcome (no impact)
bias = 0;          % reward and reward frequency inter-relation bias
p_min = .000000000000001; % lower bound probs (avoid Inf values when transforming 
p_max = .999999999999999; % upper bound probs (avoid Inf values when transforming 

load tmp;


cr = 70+5;

for b = 1:4 % loop over blocks
    if b == 1
        par = [param(1),param(2),param(3),param(4),param(5),param(6),param(7),param(8)];
    elseif b == 2
        par = [param(9),param(10),param(11),param(12),param(13),param(14),param(15),param(16)];
    elseif b == 3
        par = [param(17),param(18),param(19),param(20),param(21),param(22),param(23),param(24)];
    elseif b == 4
        par = [param(25),param(26),param(27),param(28),param(29),param(30),param(31),param(32)];
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
         
           % compute reward probabilities by marginalizing over state beliefs
           
            P(1) = par(4)*nB(1) + (1 - par(4))*nB(2);
            P(2) = (1 - par(4))*nB(1) + par(4)*nB(2);

           % distort reward probabilities
            probdistcoeff = exp(par(5)*Lo(min(p_max,max(P(1),p_min))) + (1-par(5))*log(par(7)/(1-par(7)))); 
            P_dist(1) = probdistcoeff/(1+probdistcoeff);

            probdistcoeff = exp(par(5)*Lo(min(p_max,max(P(2),p_min))) + (1-par(5))*log(par(7)/(1-par(7)))); 
            P_dist(2) = probdistcoeff/(1+probdistcoeff);

           % distort rewards
            norm_vPR = vPR/cr;
            valuedistcoeff = exp(par(6)*Lo(min(p_max,max(norm_vPR(1),p_min)))+ (1-par(6))*log(par(8)/(1-par(8)))); 
            vPR_dist(1) = valuedistcoeff/(1+valuedistcoeff);

            valuedistcoeff = exp(par(6)*Lo(min(p_max,max(norm_vPR(2),p_min))) + (1-par(6))*log(par(8)/(1-par(8)))); 
            vPR_dist(2) = valuedistcoeff/(1+valuedistcoeff);

            vPR_dist = vPR_dist*cr;
                       
           % compute decision variable
            A = diff(vPR_dist.*P_dist);
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

            % update state beliefs for the current trial
            I = x*(2-a)+(1-x)*(a-1);
            tB(1) = (par(4)^I)*((1-par(4))^(1 - I))*P(1); 
            tB(2) = ((1-par(4))^I)*(par(4)^(1 - I))*P(2);
            LLH = LLH + log(Prob(a));
            end
            
            % form state beliefs for the next trial
            sB(1) = (1 - par(1))*tB(1) + par(1)*tB(2);
            sB(2) = par(1)*tB(1) + (1 - par(1))*tB(2);
                      
        end
end

% Starting a new block
sB = [0.5, 0.5];   % initialize state beliefs
r = 0;             % initialize zero-step reward (no impact)
x = 0;             % initalize zero-step outcome (no impact)
bias = 0;          % reward and reward frequency inter-relation bias

    
end 
LLH = -LLH;

end


