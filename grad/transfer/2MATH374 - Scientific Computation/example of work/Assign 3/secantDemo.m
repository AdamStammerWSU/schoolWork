function [root,fRoot,successCode]=secantDemo(f,x0,x1,xTol,fTol)
   printStuff='true'; 
   successCode=0; 
   maxIters=50; 
   f0=f(x0);
   f1=f(x1); 
  
   if nargin < 4 
       xTol=1e-8;
       if nargin < 5
           fTol=1e-10;
       end
   end
   if abs(f0)<fTol 
      root=x0;
      fRoot=f0;
      successCode=3; % lucky guess 
      return;
   end
   if abs(f1)<fTol
      root=x1;
      fRoot=f1;
      successCode=3; % lucky guess 
      return;
   end
      
   maxIters=50; 
 
   % Optional:  if f0=f1 add safety feature to guard against horizonal
   if strcmp(printStuff,'true')
       fprintf('Iter %2d:  x%d = %16.12f,   f(x%d)=%4.2e \n',0,0,x0,0,f0);  
       fprintf('Iter %2d:  x%d = %16.12f,   f(x%d)=%4.2e \n',1,1,x1,1,f1);  
   end
   for k=2:maxIters 
      x2=(x0*f1 - x1*f0)/(f1-f0); 
      f2=f(x2);  
      if strcmp(printStuff,'true')
       fprintf('Iter %2d:  x%d = %19.16f,   f(x%d)=%4.2e \n',k,k,x2,k,f2);  

      end
      relChange= abs(x2-x1)/(abs(x1)+1e-99);
      if (relChange < xTol)
          root=x2;
          fRoot=f2; 
          successCode=1;
          return;
      end
      if abs(f2)<fTol 
          root=x2;
          fRoot=f2;
          successCode=2;
          return; 
      end
      if isnan(x2) || isinf(abs(x2)) 
          successCode=-1;
          root=[];
          fRoot=[]; 
          return;
      end
      % else: Copy Data & keep going ! 
      x0=x1; x1=x2; 
      f0=f1; f1=f2; 
      
   end
   
   

   
  
       
       
       
  








end