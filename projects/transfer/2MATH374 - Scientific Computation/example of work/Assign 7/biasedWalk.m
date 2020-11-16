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
	 weight = [1, 1, 1, 1];
   
   for k=1:maxSteps 
     % do biased random walk on an open universe   
      
      weight = [alpha^(-1*sign(x)), alpha^sign(x), alpha^(-1*sign(y)), alpha^sign(y)];
      
      prob = (1/sum(weight))*weight;
      
      r = rand();
      if r < prob(0)
        y++;
      else if r < prob(1)
        y--;
      else if r < prob(2)
        x--;
      else 
        x++;
      endif;
     
      % TO LIST 
      %    Find the "weights" for each move 
      %    Convert weights to probabilities.
      %    draw random number between 0 and 1.
      %    decide on which move to make and make the move!
     	if x == 0 && y == 0
		    break;
      end;
   end; % end stepping loop 
   
   
   return;
endfunction;
