% script for 

imgRaw = imread('binaryImg.png'); % load image 
% other images:  arch.png   hamer.jpg,  lebron.jpg


imgBW = rgbToGray(imgRaw);  % convert to monochrome image 
imgBW = double(imgBW);   

sigma = 4; 
img = gaussFilter(imgBW,4);   



C=edgeDetect(img, "centralDiff");
S=edgeDetect(img,'Sobel');
L=edgeDetect(img,'Laplacian'); 
G=edgeDetect(img,'Geometric');  



figure(323);

subplot(2,3,1); 
imagesc(imgRaw); 
title('Original');

subplot(2,3,2);
imagesc(img);  
title('BW + Gaussian Filter');  colormap(gray); 

subplot(2,3,3);
imagesc(sqrt(S)); 
title('Gradient (Sobel)');

subplot(2,3,4); 
imagesc(L); 
title('Laplacian');  


subplot(2,3,5); 
imagesc(G) ; 
title('Geometric'); 
 
subplot(2,3,6);
imagesc(C);
title('Central Gradient');




