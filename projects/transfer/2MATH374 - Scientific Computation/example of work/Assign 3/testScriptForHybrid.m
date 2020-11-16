% When grading this, I will change the functions below and check your
% answers

f1 = @(x) x.^2 - 5; 
[r1,fr1, k]=stammeraHybrid(f1,0,3,1e-8);
fprintf('\n You Have: root=%.12f;  True Answer: %.12f;  Iter:%d\n\n',r1,sqrt(5), k);  

f2=@(x) (6.0*(x-3.1))./ (40*(x-3).^2+1) +0.06*sin(50*x) + 0.01*x-0.03;
[r2,fr2, k2]=stammeraHybrid(f2,0,6,1e-12);
fprintf('\nI You Have: root=%.12f;  True Answer: %.12f; Iter:%d\n\n',r2,3.114591127875858, k2);  


