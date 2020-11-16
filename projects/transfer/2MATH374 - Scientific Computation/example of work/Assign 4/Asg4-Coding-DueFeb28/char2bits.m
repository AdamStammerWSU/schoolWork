  function [bits,charNumber]=char2bits(c,charTable,nBits)
   
   nct = length(charTable); 
   if (nct> 2^nBits)
       charTable=charTable(1:2^nBits);
   end
   
   id=find(charTable==c); % find occurences of character c in the table 
   if isempty(id)
       warning('Missing Character'); 
       fprintf(c);
       id=1;
   end
   n0 = length(id); 
   n =  ceil( n0*rand() );  
   charNumber= -1 + id(n);
   
   bits=dec2bin(charNumber); 
   q = nBits-length(bits);
   if q>0 
      bits=[repmat('0',[1 q]),bits]; 
   end

end