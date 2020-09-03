function I = montecarlo(f, a, b, n)
  % n = number of points in f
  % gussed randomly in [a,b]
  %I = (b-a) * average(f(x))
    
  fsum =0;
  for k=1:n
    r = rand();
    x = r*(b-a) + a;
    
    fsum = fsum + f(x);
    
  endfor
  
  I = (fsum / n) * (b-a);
  
  
  
  
endfunction