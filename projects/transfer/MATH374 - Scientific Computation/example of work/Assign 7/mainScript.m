% Octave Users; Uncomment next two lines if you want real time print to screen
% page_screen_output(0);
% page_output_immediately(1);

numberOfWalkers=1000; 
maxSteps=5000;
x0 =3; y0=0; z0=0;   alpha=1.1;  

% initialize counters 
wins = 0;
totalSteps=0; 
printFreq=1; 
longestWalk = 0; 
shortestWalk= 0;
for k=1:numberOfWalkers 
  s = walk3D(x0,y0,z0,maxSteps,'open',inf);   % s will be -1 if failure, or will the step number upon reaching home
  
  % update results 
  if (s>0)
     wins=wins+1; 
     totalSteps=totalSteps+s; 
     if s>longestWalk
         longestWalk=s; 
     end
     if s<shortestWalk
         shortestWalk=s;
     end
  end
  % delete the next "if" block  if you have no desire to see the progress
  if (mod(k,printFreq)==0 )
    fprintf('Walker %d ',k);
    if s<0
       fprintf('failed to get home!   '); 
    else
       fprintf('got home in %d steps.',s);
    end
    fprintf(' Overall Success Rate:  %.4f \n',wins/k); 
  end
  
  
end

probSuccess = wins/numberOfWalkers; 
results(results<0)=[]; % delete the failures 
avgSteps =totalSteps/wins; 
fprintf('\n\nSummary\n-----------------------------------------------------\n');
fprintf('Probability of Getting Home:  %.6f\n',probSuccess);
fprintf('Average Number of Steps (Given Home was found): %.2f \n', avgSteps); 
fprintf('Fastest Trip Home: %d \n', min(results));
fprintf('Longest Trip Home: %d \n\n', max(results));