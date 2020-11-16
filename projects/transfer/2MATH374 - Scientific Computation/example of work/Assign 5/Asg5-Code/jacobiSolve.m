function [x0,k]=jacobiSolve(A,b,x0,maxIters)
printIters='true'; 
residualTolerance=1e-3;

if strcmp(printIters,'true'); 
 printFreq=50; % 
 app='octave';
 try 
     page_output_immediatley(1);  
 catch 
     app='matlab';
 end 
 more off;
end



d = diag(A);  % will be a column vecto
D = diag(d); % diagonal of A, stored as sparse matrix
L = tril(A,-1); % extract lower triangular portion of A
U = triu(A,1);  % extract upper triangular portion of A
Dinv = D^(-1);   % easy to invert b/c its diagonal 
R = L + U; 

% for the SOR method,  you can use the following 4 lines to 
%   store the relevant quanitities 
% omega=1.15;
% v = omega*b;
%R = (omega-1)*D + (omega)*U;
% C =    D + omega*L;  % <-- C will be lower triangular 

% Basic Idea of SOR method
%   xNew = C^(-1) *  (v -  R*xOld) 
% Except, we can't use  

for k=1:maxIters
    temp= b - R*x0;
    x0 =Dinv * temp;
    % for the SOR method  delete the 2 previous lines 
    % and replace with 
    %  temp = v - R*x0;  % 
    %  x0 = C\temp;  % <--- solves C x = temp  by back subs.  
    r = b - A*x0;
    relativeResidual = norm(r,inf)/norm(b,inf);
    if (relativeResidual < residualTolerance)
         fprintf('\nTerminating at iteration %d due to residual tolerance being met\n\n',k);
         return;
    end
    if strcmp(printIters,'true') && (mod(k,printFreq)==0 )
     
            fprintf('Iter %d:  Rel. Residual |r|/|b| = %.3e  \n',k,relativeResidual); 
           
             
    end
    
    
  
    
    
    
    
    
end





end