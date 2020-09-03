function badImg=makeNoisyImg(img,sigma) 
   range = double( max(img(:)) - min(img(:)) ); 
   noiselevel = 0.5*sigma*range;
   badImg = double(img) + noiselevel*randn(size(img)); 
  
end  
 