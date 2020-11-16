function xNew=jacobiSolve(A,b,x0,maxIters)
  tolerance = 1e-4;

  %assignment will be gauss-sidel
  %solve 
  % d*xnew = b - (L+U)*xold
  % xnew = d' * ( b - (L+U)*xold)
  % extract upper, lower, and diag of A
  U = triu(A,1); %strict upper
  %L+D = tril(A,0);
  L = tril(A,-1);
  %D = (A - U) - L;
  D = diag(A); %diag stored as column vector (not matrix)
  % diag(sparse(D)) would return a sparse diag matrix
  % ----> must sparsify first
  
  Dinv = 1./D; %recipricate all of the diags (to make it d')
  bNorm = norm(b,inf);
  %jacobi method
  for k=1:maxIters
  
    temp = b - (L+U) * x0; 
    xNew = Dinv .* temp;
    x0 = xNew;
    %could all be one on one line!!!!
    
    r = b - A*x0; % calculate the residual (vector)
    r = norm(r,inf)/bNorm; % compute relative infinity norm;
    if r < tolerance
      return;
    endif
    %print here!!!!!
  
  endfor










%  printFreq=500;
%  residualTolerance=1e-4; 
%  d = diag(A);  % will be vector
%  dInv = 1./d; 
%  
%  L = tril(A,-1);
%  U = triu(A,1); 
%  % LplusD = tril(A,0);
%  R=L+U; 
% 
%  for k=1:maxIters
%     
%     
%     
%     temp=b - R*x0;
%     xNew = dInv .* temp;  
%     
%     
%     if mod(k,printFreq)==0 
%        r=b - A*xNew;
%        relativeResidual=norm(r,inf)/norm(b,inf); 
%        fprintf('Iter %d:  Residual: %.3e ... ',k,relativeResidual);
%       
%     
%        if (relativeResidual < residualTolerance)
%              
%              return;        
%        end  
%     end
%     x0=xNew;
%    
%    
%  end
%  
%  
%  
%  
%  
end