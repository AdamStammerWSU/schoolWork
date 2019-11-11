function prob = testBW(maxIters)
  
  fastest = 5000;
  longest = -1;
  hits = 0;
  
  for k=1:maxIters
    s = biasedWalk(20,0,1.5,500);
    if(s != -1)
      hits++;
      if(s < fastest)
        fastest = s;
      endif;
      if(s > longest)
        longest = s;
      endif;
    endif;
  endfor
  
  prob = hits / maxIters;
  
  
endfunction