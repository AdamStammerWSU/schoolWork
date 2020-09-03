function [s,distToHome,x,y,z]=walk3DGood(x,y,z,maxSteps,domainType,domainSize)

% the series of if statements below will protect against bad user inputs.
if (nargin < 6) || isempty(domainSize)   
    if (nargin < 5) || isempty(domainType) 
        domainType='closed';
        domainSize=25;
    elseif strcmp(domainType,'open');
        domainSize=inf;
    else 
        domainSize=25; 
    end
end

if ~( strcmp(domainType,'open') || strcmp(domainType,'closed') || strcmp(domainType,'torus')  )
    error('domainType must be one of open,closed, or torus'); 
end    
  
if max(abs([x,y,z])) > domainSize
    error('Initial Value (x,y,z) is outsize the domain');
end



s=-1; % failure
p = (1/6)*[1,1,1,1,1,1]; % probability vector for the moves (x+,x-,y+,y-,z+,z-)
q = cumsum(p); % cumulative probabilities are [1/6,2/6,3/6,4/6,5/6,1]
if strcmp(domainType,'open')
    count = 0; 
    while (count < maxSteps)
        r = rand();
        if r < q(1) % x+ move
            x=x+1;
        elseif r < q(2) % x- move
            x=x-1;
        elseif r < q(3) % y+ move
            y=y+1;
        elseif r < q(4) % y- move
            y=y-1;
        elseif r < q(5) % z+ move
            z=z+1;
        else
            z=z-1;
        end
        count=count+1;   
        % check if home is reached. 
        if (x==0) && (y==0) && (z==0) 
            s=count;  % record the step count and quit
            break;
        end        
    end % while loop for open universe
    
end % open universe case 


% YOUR JOB:  Complete the 

if strcmp(domainType,'closed')
    count = 0;  % Note: Only increment the count if a legal move is made
    while (count < maxSteps) 
        
    end 
end % closed universe case 



if strcmp(domainType,'torus')
    count = 0; 
    while (count < maxSteps)
       
      
    end % while loop for torus universe
    
end % torus universe case







   distToHome = sum(abs(x) + abs(y) + abs(z)); 
end




