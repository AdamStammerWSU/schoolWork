function [goodImg]=denoiseImg(filename,dataFidelity)
  
   img=loadImg(filename); %load the image (converts to monochrome)
   img = double(img); %convert 8bit ints to double precision
   
   fprintf('Image Loaded\n'); 
  
   
   
   [ny,nx]=size(img);
   A = makeFilterMatrix(img,dataFidelity); %create filtering matrix
   fprintf('Filter Matrix Construction Complete!\n'); 
   
    
   b = img(:); #convert bad pixel matrix into column vector
   
  
   u = A\b; #octaves 'gaussian eliminator' (solves Au=b)
  
   
  
   goodImg = reshape(u,ny,nx); %reshape solution back into image form
   figure(1); 
   imagesc(img);  colormap(hot);  %draw image 1
   title('Noisy Image'); 
   figure(2); 
   imagesc(goodImg);  colormap(copper); %draw image 2
   title('Good Image'); 
   
    
  
  
  
  
end