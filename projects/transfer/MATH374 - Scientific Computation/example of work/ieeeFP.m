function bitString = ieeeFP(x,nBits)
% Takes a floating point number and determine the bit structure 
%   input args:  numeric value "x" (base 10);  nBits= desired number of bits 
%   output arg:   bitString- a the binary string representing the given base 10 number
%               accoring the IEEE754 standard
% example usage  
%   ieeeFP(5.72,64) % gets the 64-bit representation of  5.72
%   bits = ieeeFP(-105.8,32);  % obtains the 32 bit reprensenation of
%   -105.8 and then stores it in the variable "bits" 
% 
%
%
%  NOTE:  I still need to fix  Underflow/Overflow to fix in 16/32 bit case


printResults='true';

if (nargin < 2)
    nBits=64;
end
if ~ ( (nBits==64) || (nBits==32) || (nBits==16) )
    warning('Second Argument must be 16,32, or 64\n Setting nBits=64\n');
    nBits=64;
end
if (nBits==64)
    eBits = 11;
    fBits = 52;
    
elseif (nBits==32)
    eBits = 8;
    fBits = 23;
    
else
    eBits=5;
    fBits=10;
    
end
bias = -1 + 2^(eBits-1);

x=double(x);
err=0;
try
    sprintf('%bx',x);
catch
    err=1;
end
if (err==0)
    myVersion='matlab';
else
    myVersion='octave';
end

if strcmp(myVersion,'matlab')
    hex = sprintf('%bx',x);
    hex=hex';
else % octave
    format hex;
    hex = disp(x);
    hex=hex(1:16)';
    format long;
end



dec = hex2dec(hex);     % decimal for each digit (1 per row)
bin = dec2bin(dec,4);    % 4 binary digits per row
bitstr = reshape(bin',[1 64]);  % string of 64 bits in order
s = bitstr(1);
e = bitstr(2:12);
f = bitstr(13:end);

p = bin2dec(e)- 1023;


if ~(nBits==64)
    f0=f(1:fBits);
    fNext=f(fBits+1);
    fTail = f(fBits+2:2*fBits);
    roundUp=1;
    if  fNext=='0'
        roundUp=0; 
    end
    zeroTail=repmat('0',[1 fBits-1]);
    if fTail(1)=='1' && fNext=='0' && strcmp(fTail,zeroTail)
        roundUp=0; 
    end
    roundUp
    f1= bin2dec(f0(1:end)) + roundUp;
    f2 = dec2bin(f1);
    nf = length(f2);
    if nf < fBits
        f= [repmat('0',[1 fBits-nf]),f2];
        kick=0;
    elseif nf==fBits
        f=f2;
        kick=0;
    else
        f=f2(2:end);
        kick=1;
    end
    p=p+kick;
    expNum = bin2dec(e)- 1023 + kick;
    if (expNum > bias)
        warning('Overflow !!');
        e='11111';
    else
        e=dec2bin(expNum+bias);
        n1=eBits - length(e);
        if n1> 0
            e = [repmat('0',[1 n1]),e];
        end
        
    end
    
    
    
    
end
bitString=[s,e,f];

if strcmp(printResults,'true');
    fprintf('\n Sign Bit: %s\n',s);
    
    fprintf(' Exp Bits: ');
    k=1;
    while(k<=eBits)
        
        m = min(k+3,eBits);
        fprintf('%s ',e(k:m));
        k=k+4;
    end
    fprintf('\nFrac Bits: ');
    k=1;
    while(k<=fBits)
        
        m = min(k+3,fBits);
        fprintf('%s ',f(k:m));
        k=k+4;
    end
    fprintf('\n');
end

base10str='0';
if (bin2dec(e)~= 0)
    
bias = -1 + 2^(-1 + eBits);
p0 = -bias + bin2dec(e);
 

X = 1;
for j=1:fBits
    X = X + str2double(f(j))*(2^(-j));
end



if (p0<fBits)

 X = num2str((2^fBits*X));
 
 decPlace=0;
 y=X;
p=-p0 + fBits;
for j=1:(p)
    [y,moveDec]=D2(y);
    
    decPlace=decPlace-moveDec;
    
    
end
nY=length(y);
crap = -1+nY+decPlace;
y = [y(1),'.',y(2:end),' x 10^(',num2str(crap),')'];
else
   
  y=num2str((X*2^p0)); 
  
end



if (s=='1')
    base10str=sprintf('-%s');
else
    base10str=sprintf('%s',y);
end



end

if strcmp(printResults,'true')
    fprintf('\nActual Base 10 Value of Binary Represenation...\n  ');
    fprintf(base10str); fprintf('\n\n');
end


    function [str,kick]=D2(a)
        
        n = length(a)+1;
        a=[a,'0'];
        
        q=zeros(1,n);
        
        
        r=0;
        for id=1:(n)
            d=  str2double(a(id)) + 10*r;
            q(id) = floor(d/2);
            r = mod(d,2);
        end
         
        if q(end)==5; kick=1; else kick=0; end;
        if (q(end)==0) && (q(1)>0)
            q=q(1:end-1);
        elseif (q(end)==0) && (q(1)==0)
            q=q(2:end-1);
        elseif (q(end)==5) && (q(1)==0)
            q=q(2:end);
            kick=1;
        end
        
        
        m=length(q); str='';
        for id=1:m
            str=[str,num2str(q(id))];
        end
        
        
        
        
    end


end


