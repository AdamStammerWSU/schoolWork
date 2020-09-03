% grad filenames of hybrid functions 
function testAsg3
fileList=dir('.\*Hybrid*.m');  % grab all files with name hybrid 
nF=length(fileList);  % n should be 1 in your directory unless you multiple "Hybrid" files 

[TC,nTC] = buildTestCases; 


fidGrading=fopen('A3-Summary.txt','w');

for k=1:nF

fname = fileList(k).name;
fname=fname(1:end-2); % drop the filename .m extension
fprintf(fidGrading,'%-20s :',fname);
report=[fname,'Report.txt'];
fid = fopen(report,'w');  % files for individual reports 
 % file summarizing results for everyone  
flag=zeros(1,nTC); 
for test=1:nTC
f=TC{test}.fcn;
trueRoot=TC{test}.root;
tolX=TC{test}.tol;
expIter=TC{test}.expectedIter; 
callStr0=sprintf('(f,%.3e,%.3e,%.3e)',TC{test}.a,TC{test}.b,tolX);
callStr=[fname,callStr0]; 
% callStr='belichickbHybrid(@(x)^2-4,-2.100e+00,-1.800e+00,1.000e-14)'




try 
  [myRoot,fRoot,iter]=eval(callStr);
catch 
  flag(test)=1;  
end
fprintf(fid,'\r\nTest %d\r\n',test);
fprintf(fid,'Octave Call:  %s\r\n',callStr); 
fprintf(fid,'True Root:  %.16f\r\n',trueRoot);

if flag(test)==1 
    fprintf(fid,'Result: ERROR\r\n');
    fprintf(fidGrading,'  ERROR;'); 
else
   fprintf(fid,'Your Root:  %.16f\r\n',myRoot); 
   relErr= abs(myRoot-trueRoot)/abs(trueRoot); 
   fprintf(fid,'Relative Error: %.3e',relErr); 
   if (relErr<1e-12)
       fprintf(fid,'   PASS\r\n');
       fprintf(fidGrading,'  PASS %2.1e;',relErr);
   else
       fprintf(fid,'   FAIL\r\n');
       fprintf(fidGrading,'  FAIL %2.1e;',relErr); 
   end
   fprintf(fid,'Iterations: %d  ',iter);
   if (iter<= expIter-2)
       msg=sprintf(' PASS!'); 
       flag(test)=1; 
   elseif (iter<= expIter+2);
       msg=sprintf(' PASS ');
   else 
       msg=sprintf(' FAIL '); 
   end
   fprintf(fid,[msg,'\r\n']); 
   fprintf(fidGrading,msg); 
   fprintf(fidGrading,' %2.d;',iter);
end   

end

fclose(fid); 
if (sum(flag)>0) 
  fprintf(fidGrading,'  Review Code');
end
fprintf(fidGrading,'\r\n');
end
fclose(fidGrading); 
fclose('all');


    function [C,ntc]=buildTestCases()
        ntc=2;
        C=cell(2,1); 
        C{1}.fcn=@(x) 0.1*(x.^5) +  2*x  + 7.2; 
        C{1}.a = -2.1;  % left end point of bracket
        C{1}.b = -1.8;  % right end point 
        C{1}.root = -2.0; % acceptable answer for root
        C{1}.tol = 1e-16;
        C{1}.expectedIter=8;
        %C{1}.msg1='f(x)= 0.1*(x.^5) +  2*x  + 7.2';
        %C{1}.msg2=sprintf('Initial Bracket [%.2f,%.2f]',C{1}.a,C{1}.b);
        %C{1}.msg3=sprintf('True Root(s): %.16f',C{1}.root); 
        
        
        C{2}.fcn=@(x) 2*atan(20*x-56.0)+3.5*exp(-4*x^2)-20*exp(-30*(x-2.9)^2)+12*exp(-20*(x-2.95)^2)+.1*sin(200*x)-.75+exp(x-4);
        C{2}.a = 0;  % left end point of bracket
        C{2}.b = 10;  % right end point 
        C{2}.root=3.0165390218980475497498; 
        C{2}.expectedIter=18;
        C{2}.tol=1e-14;      
        %C{2}.msg1='f(x)=2*atan(20*x-56.0)+3.5*exp(-4*x^2)-20*exp(-30*(x-2.9)^2)+12*exp(-20*(x-2.95)^2)+.1*sin(200*x)-.75+exp(x-4)';
        %C{2}.msg2=sprintf('Initial Bracket [%.2f,%.2f]',C{1}.a,C{1}.b);
        %C{2}.msg3=sprintf('True Root(s): %.16f',C{1}.root); 
        
        
        % C{3}.fcn=@(x) x.^2/(1000+x.^2) - 0.5; 
          
    end  
        
        
 



end