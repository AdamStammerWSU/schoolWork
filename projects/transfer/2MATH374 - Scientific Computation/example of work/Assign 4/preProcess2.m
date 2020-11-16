function  u=preProcess2(data,nChars)
    % if you reached this point: 
    %   "data" will be a column (0,1) ,  with 24 bit groups 
    %      Size of data = nChars*24
    %      Extract  bits 3,5,7,11,13,17 of each 24 bit group 
    %      and rearrange into 2D array of dim:  6 x nChars 
    
     u = zeros(6,nChars);  % preallocated; your job is to fill this in 
     v = reshape(data, 24, nChars);
     u = v([3, 5, 7, 11, 13, 17], [1:nChars]);
end