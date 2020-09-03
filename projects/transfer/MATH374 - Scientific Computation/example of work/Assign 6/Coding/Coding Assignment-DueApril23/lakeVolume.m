function [approxVolume,approxArea,averageDepth]=lakeVolume(maxIters)
   % Example Use:  [vol,area,depth]=lakeVolume(1000);   
   %                v=lakeVolume(100000);   <-- returns volume only
   
   %  Team Member Names Go Here
   %     
   % 
   %
   % DO NOT CHANGE NEXT 4 Lines 
   temp=load('lakeData.mat');
   A=temp.lakeData;   % A is a matrix, contains information on the lake geometry
   ax=0; bx=8;  % 8 x 8  kilometer grid 
   ay=0; by=8;   
   % DO NOT CHANGE PREVIOUS 4 Lines 
   
  
   
   
   % TESTING THE DEPTH FINDER <--- DELETE THIS BLOCK in final Version  
%   fprintf('\n\nTesting Lake Depth Function....\n\n');
%   for k=1:maxIters
%   xTest=ax+ (bx-ax)*rand();  %  random x-location 
%   yTest=ay +(by-ay)*rand();  %  random x-location
%   zTest=depth(xTest,yTest,A);  % depth at (x,y);  units=kilometers
%   fprintf('Grid Position:  (%5.2f,%5.2f)      Depth:  %7.2f  meters   ',xTest,yTest,1000*zTest); 
%   if (zTest<=0)
%       fprintf('  On Dry Land!');
%   end
%   fprintf('\n'); 
%   end
   % END DEPTH FINDER TEST <---  DELETE TEST in final version 
  
   
   
   % give valus to the output arguments
   approxVolume=0;  % wrong answer  
   approxArea=0;  % wrong answer  
   averageDepth=0; % wrong answer
   
   depthSum = 0.0;
   hits = 0;
   
   for i=1:maxIters
     xr = ax+ (bx-ax)*rand();
     yr = ay +(by-ay)*rand();
     s = depth(xr, yr, A);
     depthSum += s;
     %fprintf('s:  %5.2f      Depthsum: %f   \n',s, depthSum);
     if(s > 0)
       hits += 1;
       %printf("hit: %f\n", s);
     end
   end
   %printf("hits: %f\n", hits);
   approxArea = (hits/maxIters) * 64.0;
   averageDepth = (depthSum / hits);
   approxVolume = (averageDepth * approxArea);
   
   %printf("Aprox Area: %f\n", approxArea);
   %printf("Avg Depth : %f\n", averageDepth);
   %printf("Aprox Volu: %f\n", approxVolume);
   
   % END WORK HERE 
   
   
   
   
   
   
   
   
    
   % DO NOT Change Anything Below Here (unless you are trying to
   % "vectorize" the depth function 
    function Z=depth(X,Y,A)
          
          idy=min(floor(Y*64)+1,512); yD=(idy-1)/64; yU=idy/64; dy=yU-yD;
          idx=min(floor(X*64)+1,512); xL=(idx-1)/64; xR=idx/64; dx=xR-xL; 
          f00=A(idy,idx); f10=A(idy,idx+1); f01=A(idy+1,idx); f11=A(idy+1,idx+1); 
          Z1=f00 + (f10-f00).*(X-xL)./dx + (f01-f00).*(Y-yD)./dy + (f11+f00-f01-f10).*(X-xL).*(Y-yD)./dx./dy; 
          Z=Z1; 
          
    end

end