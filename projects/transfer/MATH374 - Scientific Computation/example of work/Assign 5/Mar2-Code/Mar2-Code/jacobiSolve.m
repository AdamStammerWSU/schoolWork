function xNew=jacobiSolve(A,b,x0,maxIters)
  printFreq=500;
  residualTolerance=1e-4; 
  d = diag(A);  % will be vector
  dInv = 1./d; 
  
  L = tril(A,-1);
  U = triu(A,1); 
  % LplusD = tril(A,0);
  R=L+U; 
 
  for k=1:maxIters
     
     
     
     temp=b - R*x0;
     xNew = dInv .* temp;  
     
     
     if mod(k,printFreq)==0 
        r=b - A*xNew;
        relativeResidual=norm(r,inf)/norm(b,inf); 
        fprintf('Iter %d:  Residual: %.3e ... ',k,relativeResidual);
       
     
        if (relativeResidual < residualTolerance)
              
              return;        
        end  
     end
     x0=xNew;
    
    
  end
  
  
  
  
  
end