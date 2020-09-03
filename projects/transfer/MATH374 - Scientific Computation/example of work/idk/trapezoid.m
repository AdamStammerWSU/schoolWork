function I = trapezoid(f,a,b,n)

   h = (b-a)/n;
   I = 0.5*(f(a) + f(b));
   for k=1:(n-1)
    x = a+k*h;
    I = I + f(x);
   endfor
   I = I*h;
endfunction