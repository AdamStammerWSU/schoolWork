function printDecodedMsg(msg) 
   n=length(msg); 
   fprintf('\n\n');
   for k=1:n 
       c=msg(k);
       fprintf(c);
       if (c==',' ) || (c=='.') || (c=='!') || (c==':')
           fprintf('\n');
       end
   end 
   fprintf('\n\n');
end

