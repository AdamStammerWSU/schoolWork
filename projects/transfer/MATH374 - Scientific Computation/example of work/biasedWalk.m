function [s,maxDrift] = biasedWalk(x,y,alpha,maxSteps) 
   % input args:  
   %   x,y:  Initial Positions 
   %   alpha:   bias parameter;  
   %   maxSteps:  maximum number of steps before walker gives up 
   % Output args: 
   %    s:    Number of steps it took to get home  
   %           OR  s=-1  indiciates home   %    was never reached
   %    maxDrift:   Farthest distance from home walker ever gets to. 
   s=-1; % set to failure initially 
   maxDrift=abs(x)+abs(y); 
   
   for k=1:maxSteps 
     % do biased random walk on an open universe   
  
     
     
      % TO LIST 
      %    Find the "weights" for each move 
      %    Convert weights to probabilities.
      %    draw random number between 0 and 1.
      %    decide on which move to make and make the move!
      xs = sign(x);
      ys = sign(y);
      weight = [alpha^(-1*xs), alpha^xs, alpha^(-1*ys), alpha^ys];
      
      prob = (1/sum(weight))*weight;
      
      r = rand();
      if r < prob(1)
        x++;
      elseif r < prob(1) + prob(2)
        x--;
      elseif r < prob(1) + prob(2) + prob(3)
        y++;
      else
        y--;
      endif;
     
     
     % check to see if home is reached
     distToHome = abs(x)+abs(y); 
     if distToHome ==0 
         s=k;
         return; 
     elseif distToHome > maxDrift
         maxDrift=distToHome; 
     end % end checking 
    
   end % end stepping loop 
   
   
    
end