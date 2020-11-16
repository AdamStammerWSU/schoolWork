function [root,fRoot]=yournameHybrid(f,a,b,xTol)
 % I will some of the prelim work started...   
 fa=f(a);
 fb=f(b); 
 if fa*fb> 0
    fprintf('\nWarning: [a,b] Not a valid bracketing interval\n');
    fprintf('  Returning Null Solution\n');
    root=[]; 
    fRoot=[];
    return;
 elseif fa==0
    fprintf('Lucky Guess\n');
    root=a; fRoot=fa; 
    return;
 elseif fb==0
    fprintf('Lucky Guess\n');
    root=b; fRoot=fb; 
 end  
 maxIters= ceil(log(abs(b-a)/xTol)/log(2));

 % START DOING STUFF HERE! 
 


  root=NaN; % This is wrong
  fRoot=NaN; % This is wrong 


end