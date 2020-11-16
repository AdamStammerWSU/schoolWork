function newImg = threshold(img,percentile) 
    % inputs:  
    %     img:  images (as 2D array) 
    %     level:  number between 0 and 1  (0.5 = median) 
    
      % turn image into column vector
     a = min(min(img)); % calculate minimum pixel intensity 
     b = max(max(img));  % calculate maximum pixel intensity 
     [ny,nx]=size(img);  % ny=number of rows (y-coords); nx = number of cols (x-coords)
     newImg=zeros(ny,nx); % allocate space for newImg
     
     % Your Job:   make a new Image (newImg) where: 
     %  (1) Any pixel value in the original at level of percentile or
     %  higher gets set to 1 (max) in the newImage
     %  (2) Any pixel value below the given percentile is set to 0
     % 
     %   For example if A = [1,2,3;  2.1 ,5 , 7 ] 
     %     then calling newImg = threshold(A,0.2)  should produce 
     %       [0,0,1; 0,1,1];      
     %   This is because the 20th percentile is 2.2 
     % 
     r = b-a;
     p = (percentile)*r+a;
     newImg=(img>=p);
     %newImg=newImge(:);
     




end