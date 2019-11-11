function A=makeFilterMatrix(img,dataFidelity) 
    [ny,nx]=size(img); 
    vx =ones(nx,1); vy=ones(ny,1);
    Lx = spdiags([vx,-2*vx,vx],[-1,0,1],nx,nx); Lx(1,nx)=1;  Lx(nx,1)=1;
    Ly = spdiags([vy,-2*vy,vy],[-1,0,1],ny,ny); Ly(1,ny)=1;  Ly(ny,1)=1; 
    Ix = speye(nx,nx); Iy = speye(ny,ny); 
    L = kron(Ix,Ly) + kron(Lx,Iy); 
    N=nx*ny; 
    I = speye(N,N);
    A = I - (1/dataFidelity)*L; 
end