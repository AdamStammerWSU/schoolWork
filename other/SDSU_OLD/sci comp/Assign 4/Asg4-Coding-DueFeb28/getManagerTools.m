function [P,pad,characterTable] =  getManagerTools()
filename='charTable.txt'; 
I = eye(12);
p=  [7, 5, 9, 1, 3, 12, 4, 6, 10, 8, 11, 2];
P =zeros(12);
for k=1:12 
  P(k,:) = I(p(k),:);
end
pad = 1*[1;0;1;1;1;0;1;0;1;1;0;1]; 
  

 fid=fopen(filename,'r'); 
 characterTable=fscanf(fid,'%c');  
 fclose(fid); 


end

