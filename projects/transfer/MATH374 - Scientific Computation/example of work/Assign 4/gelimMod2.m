function [x]=gelimMod2(A,b)

  % Get dimensions size of args; Check for consistency 
  [nra,nca]=size(A);
  [nrb,ncb]=size(b);
  if (nra ~= nca) 
     error('First Argument (A) must be a square matrix.  You had:  row dim <>  col dim!! ');
  else 
     n=nra;  % now we can speak of row dim and col dim as same thing!
  end
  if (nra~=nrb) || (ncb~=1)
     error('Second Arg (b) must a column of same row dimension as the coefficient matrix A'); 
  end
  % Done with initial consistency check
  

  
  A=[A,b]; % augment
  % march across columns and do row ops for Gaussian Elim
  for c=1:n
    
    if (A(c,c)==0) % search for pivot (Naive Scheme: If 0, find first thing that is not zero)
      for r=(c+1):n
         if (A(r,c)~=0)
            % swap rows c and  r 
            temp=A(r,:); % all of row r
            A(r,:) = A(c,:);
            A(c,:) = temp;
            break; 
         end
      end
    end % end of pivot search
    
	if (A(c,c)==0)
	   warning('Matrix is Singular: Returning Null Solution');
	   x=[]; 
	   return; 
	end
    % Elimination Phase
    % for every row below pivot,  gets 0's in pivot columns
    for r=(c+1):n
      multiplier=A(r,c);  % if in mod 2, A(c,c) will be 1, no need to divide
      temp1=A(r,:);
      temp2=multiplier*A(c,:);
      A(r,:) = temp1-temp2;
      A(r,:) = mod(temp1 - temp2,2); 
    end % elimination for col c
     
  end % GE column march
  
  
  % GE OVER;  
  % Do BACK-SUBSTITUTIONto get x 
  x=zeros(n,1); % allocate for x 
  b = A(:,n+1); % extract right-side of eqn from augemented matrix
  for r=n:(-1):1  % bottom to top 
    s=b(r); % b was in last column 
    for c=(r+1):nca 
      s=s - A(r,c)*x(c); 
	    s=mod(s,2);
    end
    x(r) = s; % in mod 2, if you have made it this far, then A(r,r)=1
    
  end
 
  
  
  
  
  
  
  
end