function  [msg,msg12,msg13,msg23]=mainFcn()
workerShowsUp=[1,1,1];  % [1,0,1] would mean #2 is not present.
if sum(workerShowsUp)<2
    warning('Insufficient Workers to Decode Message');
    
    return;
end
msg='0'; msg12='1'; msg13='2'; msg23='3';
%

[A1,A2,A3]=getWorkerTools();
[P,pad,charTable]=getManagerTools();
% load worker data streams
[data1,data2,data3]=receiveWorkerData();   % automatically calibrates size of data sets
% data1:  16 bit groups
%         First 6 bits  important, last 10 are trash
% data2:  24 bit groups
%         Bits 3,5,7,11,13,17 important,  the rest are trash
% data3   12 bit groups
%         Bits 2,4,6,8,10,12 important,  the rest are trash
nChars=length(data1)/16;   % total number of characters

% pre Process the binary strings
u1 = preProcess1(data1,nChars);
u2 = preProcess2(data2,nChars);
u3 = preProcess3(data3,nChars);



% scenario 1&2:  Both Workers 1,2 show up to work;
if (workerShowsUp(1)==1) && (workerShowsUp(2)==1)
    A12 = [A1;A2];  %  Concatenate their decoding matrices
    u12 = [u1;u2];  %  Concatenate their 6 bit stream arrays
    msg12='';
    for k=1:nChars
        b =u12(:,k);  % extract column of "stacked" bit stream (will by 12 x 1)
        x = gelimMod2(A12,b);   % solve Ax = b in mod 2
        msg12(k) = bits2char(x,P,pad,charTable);  % pass decoded bits to the manager
    end
    if workerShowsUp(3)==0
        msg=msg12;
    end
end
% scenario 1&3:  Both Workers 1,3 show up to work;
if (workerShowsUp(1)==1) && (workerShowsUp(3)==1)
    
    A13 = [A1;A3];
    u13 = [u1;u3];
    msg13='';
    for k=1:nChars
        b =u13(:,k);  % extract column of "stacked" bit stream (will by 12 x 1)
        x = gelimMod2(A13,b);   % solve Ax = b in mod 2
        msg13(k) = bits2char(x,P,pad,charTable);  % pass decoded bits to the manager
    end
    if workerShowsUp(2)==0
        msg=msg13;
    end
end

% scenario 12&3:  Both Workers 2,3 show up to work
if (workerShowsUp(2)==1) && (workerShowsUp(3)==1)
    A23 = [A2;A3];
    u23 = [u2;u3];
    msg23='';
    for k=1:nChars
        b =u23(:,k);  % extract column of "stacked" bit stream (will by 12 x 1)
        x = gelimMod2(A23,b);   % solve Ax = b in mod 2
        msg23(k) = bits2char(x,P,pad,charTable);  % pass decoded bits to the manager
    end
    if workerShowsUp(1)==0
        msg=msg23;
    end
end


if strcmp(msg12,msg23) && strcmp(msg12,msg13)
    msg=msg12; 
    fprintf('Message Fully Validated!\n');
elseif strcmp(msg12,msg13)
    fprintf('Message Partially Validated (1-2,1-3 agree,2-3 negative)\n');
    msg=msg12; 
elseif strcmp(msg13,msg23)
    fprintf('Message Partially Validated (1-3,2-3 agree,1-2 negative)\n');
    msg=msg13;
else
    msg=msg12;
    fprintf('\n\nMessage Not Validated\n\n');
end


printDecodedMsg(msg);

end