function I = montecarlo2(f, a, b, c, d, n)
  % n = number of points in f
  % gussed randomly in [a,b]
  %I = (b-a) * average(f(x))
    
    
    
    fsum =0;
    for k=1:n
      r = rand();
      r2 = rand();
      x = r*(b-a) + a;
      y = r2*(d-c) + c;
      
      fsum = fsum + f(x,y);
      
    endfor
    
    I = (fsum / n) * (b-a)*(d-c);
  
  
endfunction