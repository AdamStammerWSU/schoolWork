function [goodImg]=denoiseImg(filename,dataFidelity)
  
   img=loadImg(filename); 
   img = double(img);
   
   fprintf('\nImage Loaded\n'); 
  
   
   
   [ny,nx]=size(img);
   A = makeFilterMatrix(img,dataFidelity);
   fprintf('Filter Matrix Construction Complete!\nStarting Solver...\n\n'); 
   
    
   b = img(:); 
   
   maxIters=10000; 
   x0=zeros(size(b)); 
   [u,iter] = sorSolve(A,b,x0,maxIters);
   % [u,iter] = jacobiSolve(A,b,x0,maxIters);
  
   
   goodImg = reshape(u,ny,nx); 
   figure(1); 
   imagesc(img);  colormap(hot); 
   title('Noisy Image','FontSize',20); 
   figure(2); 
   imagesc(goodImg);  colormap(copper);
   r = norm(b - A*u,inf)/norm(b,inf); 
   msg=sprintf('Denoised Image\nData Fidelity: alpha=%.5f\n%d Iterations \n Rel. Res |r|/|b| = %.3e ',dataFidelity,iter,r); 
   title(msg,'FontSize',20); 
  
   figure(3); 
   subplot(1,3,1); 
    threshImg = threshold(goodImg,0.3);   
    
    imagesc(threshImg); colormap(gray);
    title('Threshold Level 0.3','FontSize',16); 
   subplot(1,3,2); 
    threshImg = threshold(goodImg,0.5);   
    imagesc(threshImg); colormap(gray);
    title('Threshold Level 0.5','FontSize',16); 
   subplot(1,3,3); 
    threshImg = threshold(goodImg,0.7); 
    imagesc(threshImg);  colormap(gray); 
    title('Threshold Level 0.7','FontSize',16); 
   
    
  
  
  
  
end