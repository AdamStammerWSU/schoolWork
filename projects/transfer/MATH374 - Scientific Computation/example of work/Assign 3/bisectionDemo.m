function [x_app,F_app]=bisectionDemo(F,a,b,tol)
printResults='true';
if (nargin < 4) || (tol <=0)
    tol=1e-6;  % set default value for tolerance
end
% compute function values
Fa=F(a);
Fb=F(b);
% Do not do algorithm if there is an invalid guess
%   or if the user guesses the root exactly
if (Fa*Fb) > 0  % bad guess for [a,b]
    x_app=[];
    F_app=[]; 
    warning('F(a) and F(b) must have opposite sign. No solution returned');
    return;
elseif (Fa==0) % lucky guess
    x_app=a;
    F_app=F_a;
    return
elseif (Fb==0)  % lucky guess
    x_app=b;
    F_app=F_b;
    return;
end
% Do bisection algoritm
if nargin <=4 
   n=log(abs(b-a)/tol)/log(2); % calculate number of iterations
   n = ceil(n); % round up
end

for k=1:n
    m = 0.5*(a+b);
    Fm = F(m);
    if strcmp(printResults,'true');
        fprintf('Iter %d\n',k);
        fprintf('   a=%20.16f     b=%20.16f     m=%20.16f\n',a,b,m);
        fprintf('F(a)= %5.3e           F(b)= %5.3e            F(m)= %5.3e \n',Fa,Fb,Fm);
        fprintf('-----------------------------------------------------------------------\n');
        pause;
    end
    if Fa*Fm > 0  % set a=m, keep b as is 
        a=m;
        Fa=Fm;
    elseif Fb*Fm > 0 % set b=m, keep a as is 
        b=m;
        Fb=Fm;
    elseif Fm==0
        break;  % landed on the root 
    end
end % bisection for loop

x_app=0.5*(a+b);  % estimated root is the midpoint of last [a,b]
F_app=F(x_app);  % Backward Error 







end