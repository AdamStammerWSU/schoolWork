function x=classCode(A,b)

  [nra, nca] = size(A);
  A=[A,b]; %augment b into a (like on paper)
  %march across columns and do row ops for gaussian elimination
  for c=1:nca
    if(A(c,c)==0) %search for pivot
      for r=c+1:nra
        %naive pivotting
        if(A(r,c) ~= 0) % do a row swap (valid pivot found)
          temp = A(r,:); %store all of row r
          A(r,:)=A(c,:); %all of row c = all of row r
          A(c,:) = temp; %row c now equals temp (all of row c)
          break;% quit searching once valid pivot found
        end
        
      endfor
    endif
    
    %elimination phase
    for r=(c+1):nra%go through all rows in column and zero
      multiplier=A(r,c)/A(c,c);
      A(r,:) = A(r,:) - (multiplier * A(c,:)); %row = row - multiplier * pivot row
      %A(r,:) = mod(A(r,:),2);
    endfor %done g eliminating
    
    %GE OVER; do back substitution
    x=zeros(nra,1);
    for r=nra:(-1):1
      s=A(r,nca+1); %b was in the last column
      for c=nca:(-1):(r+1)
        s= s + A(r,c)*x(c);
      endfor
      x(r) = s/A(r,r);
      %replace x with x mod 2
    endfor
    
  endfor %%main ge loop
endfunction