function c = bits2char(x,P,pad,characterTable) 
  m = length(x) ;
  x = reshape(x,m,1);
  x = mod(x + pad,2);
  x = (P')*x;
  p = (m-1):(-1):0;
  charNumber= 1+(2.^p)*x;
  c = characterTable(charNumber); 
  


end

