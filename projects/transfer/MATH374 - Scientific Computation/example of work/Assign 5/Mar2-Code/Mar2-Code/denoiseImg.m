function [goodImg]=denoiseImg(filename,dataFidelity)
  
   img=loadImg(filename); 
   img = double(img);
   
   fprintf('Image Loaded\n'); 
  
   
   
   [ny,nx]=size(img);
   A = makeFilterMatrix(img,dataFidelity);
   fprintf('Filter Matrix Construction Complete!\n'); 
   
    
   b = img(:); 
   
  
   u = A\b;
  
   
  
   goodImg = reshape(u,ny,nx); 
   figure(1); 
   imagesc(img);  colormap(hot); 
   title('Noisy Image'); 
   figure(2); 
   imagesc(goodImg);  colormap(copper);
   title('Good Image Image'); 
   
  
    
  
  
  
  
end