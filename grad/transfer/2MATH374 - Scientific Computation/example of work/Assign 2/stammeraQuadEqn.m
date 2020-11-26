function [root1,root2]=stammeraQuadEqn(a,b,c) 
% Returns 2 roots of the equation  ax^2 + bx + c = 0 
%    Example Call: [r1,r2]=yournameQuadEqn(1,0,-4)  
%           to solve  x^2 - 4 = 0
% change "yourname" then file name and function header name 
%  yourname should first 7 or less letters of last and first initial 
%  Ex:  "Matt Biesecker" would have bieseckmQuadEqn.m 
%  Ex:  "Sandra Po" would have posQuadEqn.m 
% 
%  

Delta=b^2 - 4*a*c; 
% Insert code in the appropriate locations where it says "INSERT CODE" 
%     The goal is choose the form of the root to avoid "loss of
%     significance" arising from adding a positve to negative  
%  Possible real roots when b^2 - 4ac > 0 
%     Std form: root1= (-b + sqrt(Delta))/(2*a)   <-- loss of sig when b>0
%     Alt form:  root1= (2*c) / ( a*(-b - sqrt(Delta) ) )
%
%     Std form:  root2= (-b - sqrt(Delta))/(2*a)  <-- loss of sig when b<0 
%     Alt form:  root2=  (2*c)/ (a* (-b + sqrt(Delta) ) )
if (Delta > 0)  % 2 real roots 
   if (b > 0) 
      root1 = (2*c) / ( a*(-b - sqrt(Delta) ) ); 
      root2 = (-b - sqrt(Delta))/(2*a);
   elseif (b<0)
      root2 = (2*c)/ (a* (-b + sqrt(Delta) ) );
      root1 = (-b + sqrt(Delta))/(2*a);
   else % b=0 
       root1 = 0;
       root2 = 0;
       
   end % nested if 
   
elseif (Delta < 0) % imaginary roots ;  don't change this block 
   sqrtDelta= 1i * sqrt(-Delta);  % 1i (no space) is the imag number i in matlab 
   root1 = (-b + sqrtDelta)/(2*a); 
   root2 = (-b - sqrtDelta)/(2*a); 
else % Delta=0 (repeated roots) ;  don't change this block 
  root1=-b/(2*a);
  root2=root1; 
end
    
    
    
    
end