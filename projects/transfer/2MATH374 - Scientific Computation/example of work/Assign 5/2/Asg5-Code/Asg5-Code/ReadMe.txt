1) Don't change the following functions 

 loadImg.m 
 makeFilterMatrix.m 
 jacobiSolve.m 
 rgb2Gray.m 
 makeNoisyImg.m 
 denoiseImg.m 
 
2) The functions you must complete 

  sorSolve.m   (solves Ax=b via SOR method; see hints in "jacobiSolve") 
  saveImg.m
  threshold.m 

3) To test whether you are doing it correctly,  
type and enter the following at the commmand lineL: 

denoiseImg('testImg.png',0.01) 