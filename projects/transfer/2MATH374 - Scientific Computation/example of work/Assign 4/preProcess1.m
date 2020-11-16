function  u=preProcess1(data,nChars)
    % if you reached this point: 
    %   "data" will be a column (0,1) ,  with 16 bit groups 
    %      Size of data = nChars*16 
    %      Extract first 6 bits of each 16 bit group 
    %      and rearrange into 2D array of dim:  6 x nChars 
    
     u = zeros(6,nChars);  % preallocated; your job is to fill this in
     v = reshape(data, 16, nChars);
     u = v([1:6], [1:nChars]);
     %u = v([1:nChars], [1:6]);
end