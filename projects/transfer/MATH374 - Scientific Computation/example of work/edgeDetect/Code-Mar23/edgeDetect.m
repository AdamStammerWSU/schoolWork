function C=edgeDetect(img,method)
  
 [ny,nx]=size(img); 
  % To Do  1) Dewitt:  Mask:  Dx [-1 0 1;  -1 0 1; -1 0 1];    
  %  Dy [-1 -1 -1; 0 0 0 ;  1 1 1];
  %  
  % 2) 5 Pt Laplacian [1 1 1 1 1; 1 1 1 1 1; 1 1 -24 1 1; 1 1 1 1 1; 1 1 1
  % 1 1]; 
  
  if strcmp(method, 'centralDiff')
    C=zeros(ny,nx);
%    for x=2:(nx-1) 
%      for y=2:(ny-1)
%        %find x deriv at point(x,y) (y,x) because of c-r major
%        ix=img(y,x+1) - img(y,x-1); %mask of (1/2)[-1 0 1];
%        ix = ix/2;
%        iy = img(y-1,x) - img(y+1,x); %vertical mask from above
%        iy = iy/2;
%        C(y,x) = sqrt(ix*ix+iy*iy); %magnitude of gradient
%      end
%    end
    xMask=.5.*[-1,0,1];
    yMask=.5.*([-1,0,1]');
    ix = conv2(xMask, img);
    iy = conv2(yMask, img);
    ix = ix(:,2:end-1);
    iy = iy(2:end-1,:);
    C = sqrt(ix.*ix + iy.*iy);
    figure(1);
    subplot(1,3,1);
    imagesc(ix);
    subplot(1,3,2);
    imagesc(iy);
    subplot(1,3,3);
    imagesc(C);
    
  end
  
  if strcmp(method,'Sobel'); 
   N =nx*ny;
   e = ones(N,1);
   Dx = spdiags([-e -2*e -e  e 2*e e],[-ny-1, -ny, -ny+1,  ny-1, ny, ny+1],N,N);
   Dy = spdiags([-e  e -2*e 2*e  -e  e],[-ny-1 ,-ny+1, -1  1, ny-1, ny+1],N,N);
   Ix = (Dx)*img(:);
   
   Iy = (Dy)*img(:); 
   
  

   G = sqrt(Ix.^2 + Iy.^2); 
   rng = max(G) - min(G); 
   G = (G - min(G(:)))/rng; 
   G = reshape(G,ny,nx); 
  
   C = G(3:end-2,3:end-2); 
   C = C/max(C(:));
   
  end

  

   

 
  
  
  if strcmp(method,'Laplacian'); 
  ex=ones(nx,1);  ey=ones(ny,1); 
  Ix=speye(nx,nx); Iy = speye(ny,ny);   
  Dxx = spdiags([ex,-2*ex,ex],[-1 0 1],nx,nx); Dxx(1,nx)=1;  Dxx(nx,1)=1; 
  Dyy = spdiags([ey,-2*ey,ey],[-1 0 1],ny,ny); Dyy(1,ny)=1;  Dyy(ny,1)=1;
  Dxx = kron(Dxx,Iy);
  Dyy = kron(Ix,Dyy);   
  C = (Dxx + Dyy)*img(:);   
  C = reshape(C,ny,nx);
  C = C(3:end-2,3:end-2);
  C = C/max(C(:)); 
  end
  
  
  if strcmp(method,'Geometric')
  ex=ones(nx,1);  ey=ones(ny,1); 
  Ix=speye(nx,nx); Iy = speye(ny,ny);
  Dx = 0.5*spdiags([-ex,ex],[-1  1],nx,nx); Dx(1,nx)=-0.5; Dx(nx,1)=0.5; 
  Dy=  0.5*spdiags([-ey,ey],[-1  1],ny,ny); Dy(1,ny)=-0.5; Dy(ny,1)=0.5; 
  Dx=kron(Dx,Iy); 
  Dy = kron(Ix,Dy); 
   Dxx = spdiags([ex,-2*ex,ex],[-1 0 1],nx,nx); Dxx(1,nx)=1;  Dxx(nx,1)=1; 
  Dyy = spdiags([ey,-2*ey,ey],[-1 0 1],ny,ny); Dyy(1,ny)=1;  Dyy(ny,1)=1;
  Dxx = kron(Dxx,Iy);
  Dyy = kron(Ix,Dyy);   
  
  Dxy = Dy*Dx;
  Dxyy = Dx*Dyy;
  Dxxy = Dxx*Dy; 
  Dxxx= 1/2*spdiags([-ex, 2*ex,-2*ex, ex],[-2 -1 1 2],nx,nx);  Dxxx(1,nx-1)=-0.5; Dxxx(1,nx)=1;  Dxxx(nx,2)=0.5; Dxxx(nx,1)=-2;  Dxxx(2,nx)=-0.5;  Dxxx(nx-1,1)=0.5; 
  Dyyy= 1/2*spdiags([-ey, 2*ey,-2*ey, ey],[-2 -1 1 2],ny,ny);  Dyyy(1,ny-1)=-0.5; Dyyy(1,ny)=1;  Dyyy(ny,2)=0.5; Dyyy(ny,1)=-2;  Dyyy(2,ny)=-0.5;  Dyyy(ny-1,1)=0.5; 
  Dxxx=kron(Dxxx,Iy);
  Dyyy=kron(Ix,Dyyy); 
  
  v = img(:); 
  
  vx = Dx*v; vy = Dy*v; vxx = Dxx*v; vxy = Dxy*v;  vyy = Dyy*v; 
  I2 = vx.^2 .* vxx + 2*vx.*vy.*vxy + vy.^2 .* vyy;
  I2 = reshape(I2,ny,nx); 
  
  %vxxx = Dxxx*v; vyyy = Dyyy*v;  vxxy = Dxxy*v;  vxyy = Dxyy*v;
  %I3 = vx.^3 .* vxxx + 3*vx.^2 .* vy .* vxxy + 3*vx.* vy.^2 .* vxyy + vy.^3 .* vyyy; 
  %I3 = reshape(I3,ny,nx); 
  I2 = I2(3:end-2,3:end-2); 
  C = I2/max(abs(I2(:)));
  C = C./( sqrt(abs(C)) + eps); 
  
  end
  
  
  
end