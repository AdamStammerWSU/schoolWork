function  u=preProcess3(data,nChars) % if you reached this point: 
    %   "data" will be a column (0,1) ,  with 12 bit groups 
    %      Size of data = nChars*12
    %      Extract bits 2,4,6,8,10,12 of each 12 bit group 
    %      and rearrange into 2D array of dim:  6 x nChars 
    
     u = zeros(6,nChars);  % preallocated; your job is to fill this in 
end