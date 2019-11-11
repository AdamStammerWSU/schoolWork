function saveImg(img,filename)
  % utility that will convert type "double" array into uint8 
  %  and save as filename
   
   newImg=ones(size(img));  % allocate space for new img
    
   % YOUR JOB
   % preprocess the input image 'img' so that:  
   %  1. max Value of img is converted  to 255 
   %     min Value is img is converted  to 0 
   %     intermediate values converted to values between 0 and 255
   %  2. finally, round all values to integers and store result in 'newImg' 
   newImg = 255.*newImg;
   newImg = newImg.*img;
   newImg = round(newImg);
   
   imwrite(newImg,filename);  % saves the image 
  
    
  
  
  
  
  
end