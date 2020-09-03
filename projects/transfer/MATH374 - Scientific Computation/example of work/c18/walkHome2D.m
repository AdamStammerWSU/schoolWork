function steps=walkHome2D(x,y,maxIters,domainSize)
     
     plotResults='true'; 
     animate='true'; 
     if (nargin < 4) || (isempty(domainSize))
        domainSize=inf;
     end
     
     if (nargin < 3) || (isempty(maxIters))
        maxIters=10000;
     end
     
     if strcmp(plotResults,'true')
       xHistory=zeros(maxIters,1);
       yHistory=zeros(maxIters,1); 
       xHistory(1)=x;
       yHistory(1)=y; 
       picDim=2*max(abs([x y])); 
     end
     
     steps=-1; %-1 is failed state
     p =[0.25,0.25,0.25,0.25];  %chances of each direction
     cp = cumsum(p); 
     for k=2:maxIters
         r=rand();  % roll the dice 0-1(uniform distribution)
         if r<cp(1) %<.25 go right
           x=x+1;
           if(x > domainSize)
            x = -domainSize;
           end 
         elseif r<cp(2) %.25<.5 go left
           x=x-1; 
           if(x < -domainSize)
             x = domainSize;
           end;
         elseif r< cp(3) %.5<.75 go down
           y=y+1;
           if(y > domainSize)
             y = -domainSize;
           end;
         else           % go up
           y=y-1; 
           if(y < -domainSize)
             y = domainSize;
           end
         end
         
         %setup torus universe (teleport to other side
         
         
         
         
         if strcmp(plotResults,'true') 
           xHistory(k)=x;
           yHistory(k)=y; 
           if strcmp(animate,'true') 
            plot(xHistory(1:k),yHistory(1:k)); hold on; 
            plot(xHistory(1),yHistory(1),'m*','MarkerSize',12);
            plot(x,y,'r.','MarkerSize',16); 
            plot(0,0,'go','MarkerSize',16); 
            axis([-picDim picDim -picDim picDim]); 
            hold off;
            if max(abs([x y])) >= picDim
              picDim=1.25*picDim;
            end
            pause(0.01); 
           end
         end
         
         
         
         %check to see if you're home
         if (x==0) && (y==0)  % reached home 
            steps=k; % record the step 
            break; 
         end
         
     end
     
     
  
  
  
  
  
  
  
  
  
  
  
end