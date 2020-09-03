function newImg = rgbToGray(img) 
  % convert RGB (3 channel image) into grayscale
  
  if size(img,3)==3
     R=double(img(:,:,1));
     G=double(img(:,:,2));
     B=double(img(:,:,3)); 
     
     newImg=0.299 * R + 0.587 * G + 0.114 * B;
     if isinteger(img) 
        newImg=uint8(newImg); 
     end
  else  
     newImg=img;    
  end
   

end