function [root,fRoot,k]=stammeraHybrid(f,a,b,xTol)
 % I will some of the prelim work started...   
 fa=f(a);
 fb=f(b); 
 if fa*fb> 0
    fprintf('\nWarning: [a,b] Not a valid bracketing interval\n');
    fprintf('  Returning Null Solution\n');
    root=[]; 
    fRoot=[];
    return;
 elseif fa==0
    fprintf('Lucky Guess\n');
    root=a; fRoot=fa; 
    return;
 elseif fb==0
    fprintf('Lucky Guess\n');
    root=b; fRoot=fb; 
 end  
 maxIters= ceil(log(abs(b-a)/xTol)/log(2));
 k=maxIters;
 % START DOING STUFF HERE! 
 x0=a;
 x1=b;
 f0=fa;
 f1=fb;
 doSecant=1;
 lastStep = 1;
 fence = 1e-10;
 
 for i = 1:maxIters
     
    printf("Iter %d:\n", i);
   #{
   x2=(x0*f1 - x1*f0)/(f1-f0); 
      f2=f(x2);
      relChange= abs(x2-x1)/(abs(x1)+1e-99);
      if (relChange < xTol)
          root=x2;
          fRoot=f2; 
          successCode=1;
          return;
      end
      if abs(f2)<fTol 
          root=x2;
          fRoot=f2;
          successCode=2;
          return; 
      end
      if isnan(x2) || isinf(abs(x2)) 
          successCode=-1;
          root=[];
          fRoot=[]; 
          return;
      end
      % else: Copy Data & keep going ! 
      x0=x1; x1=x2; 
      f0=f1; f1=f2;
   #}
    %secant loop
    if doSecant == 1
      lastStep = 1;
      printf("            Secant!\n");
      x2=(x0*f1 - x1*f0)/((f1-f0));
      f2=f(x2);
      relChange = abs(x2-x1) / (abs(x1) + 1e-99);
      if (relChange < xTol)
          root=x2;
          fRoot=f2; 
          k=i;
          return;
      end
      if abs(f2)<xTol 
          root=x2;
          fRoot=f2;
          k=i;
          return; 
      end
      if (x2>b) || (x2<a) || f1==f2
        doSecant=-1;
      else
      x0=x1;
      x1=x2; 
      f0=f1;
      f1=f2; 
      end
      
    end
    #}
    if doSecant < 1
        lastStep = 0;
        printf("Bisecting!\n");
        m=0.5*(a+b);
        fm=f(m);
        if(fa*fm > 0)
          a=m;
          fa=fm;
        elseif(fb*fm > 0)
          b=m; 
          fb=fm;
        elseif(fm==0)
          root=m;
          fRoot=fm;
          k=i;
          return;
        endif
        doSecant = doSecant + 1;
        if(doSecant==1)
          x0=a;
          x1=b;
          f0=fa;
          f1=fb;
        endif
    end
    
    
    if(lastStep != 1)
      if(abs(b-a) < fence)
          root=0.5*(a+b);
          fRoot=f(root);
          k=i;
          return;
      endif
    else
      if ((abs(x1-x0)/abs(x0) + 1e-99) < fence)
        root=x1;
        fRoot=f(root);
        k=i;
        return;
      endif
    end 
    lastStep = doSecant;
 endfor


  root=NaN; % This is wrong
  fRoot=NaN; % This is wrong
  k=inf;

endfunction