function I = simpson(f, a, b, n)

  if mod(n,2) ~= 0 %%n must be even
    warning('n must be even. correcting');
    n= 2*ceil(n/2);
  endif
  h = (b-a)/n;
  m = n/2; % number of groupings (double use of interior)
  I = 0;
  for k=1:m
    x = a + 2*(k-1)*h;
    I = I + f(x) + 4*f(x+h) + f(x +2*h);
  endfor
  I = (h/3)*I;

endfunction