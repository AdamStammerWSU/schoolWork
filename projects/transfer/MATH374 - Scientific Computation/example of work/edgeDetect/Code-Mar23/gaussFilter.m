function img= gaussFilter(img,sigma) 
   [ny,nx]=size(img); 
   ex=ones(nx,1); ey = ones(ny,1); 
   if (nargin<2) || (sigma <=0)
       sigma=0.5;
   end
   
   if sigma < 1 
     r = 1; 
   elseif sigma<=4.0 
     r=2;
   elseif sigma<=8.0 
     r=3;
   elseif sigma <=10  
     r=5;
   else 
     r=11;
   end
   
   
   v = exp( - 0.5*(-r:r).^2/sigma^2); 
   v = v/sum(v)
   m=length(v); 
   dx = zeros(nx,m);
   dy = zeros(ny,m); 
   for k=1:m 
     dx(:,k) = v(k)*ex; 
     dy(:,k) = v(k)*ey; 
   end
   Fx = spdiags(dx,-r:r,nx,nx);  
   Fy = spdiags(dy,-r:r,ny,ny);  
   for k=1:r 
       t=Fx(k,:); s=Fy(k,:);
       Fx(k,:)=t/sum(t); Fy(k,:)=s/sum(s); 
       t=Fx(nx-k+1,:); s=Fy(ny-k+1,:); 
       Fx(nx-k+1,:)=t/sum(t); Fy(ny-k+1,:)=s/sum(s); 
   end

   F = kron(Fx,Fy); 
   
   img=F*img(:);
   img = reshape(img,ny,nx); 



   

  
   




end