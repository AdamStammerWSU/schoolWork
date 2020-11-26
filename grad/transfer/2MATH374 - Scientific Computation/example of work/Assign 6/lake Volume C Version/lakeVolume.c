/* C code for the Lake Volume problem

1) Put data file "lakeData.txt" in the same directory as lakeVolumeC.c

2) Complile:   gcc -lm  lakeVolume.c


*/

#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <math.h>
#include <time.h>
#define DIM 512

void getLakeData(double **);
double depth(double x,double y,double **A);
int main(int argc, char *argv[])
{

double **Lake;
unsigned long i,j,k, funCalls=0, monteCarloIters;
double x,y,z;

double s=0, volumeMC=0, areaMC=0, pct;
unsigned long hits=0;
unsigned check;

/* Get number of intervals for Trap. Method  and
number of iterations for Monte Carlo */

if (argc<=1)
{
  printf("How Many Iterations ? ");
  scanf("%ld", &monteCarloIters);
}
else if (argc>=2)  // if command line args were passed
   monteCarloIters=atoi(argv[1]);







// Initialize Array for Lake Data
Lake=malloc((DIM+1)*sizeof(double));
for(i=0;i<=DIM;i++)
      Lake[i]=malloc( (DIM+1)*sizeof(double));
// Load the Lake Data
getLakeData(Lake);
printf("\nLake is loaded and ready to go!\n\n");



srand(time(0)); // seed the RND



// Testing the Dept. Finder;  Currently the loop only reports the depth
for(i=0;i<monteCarloIters;i++)
{
  x=8* ( (double) rand()/RAND_MAX ) ;
  y=8* ( (double) rand()/RAND_MAX ) ;
  z=depth(x,y,Lake); funCalls=funCalls+1;

  if (z>0)
     printf("At (x,y)=(%.3f km,%.3f km), the depth is %.3f meters \n" ,x,y,1000*z);
  else
     printf("  DRY LAND (x,y)=(%.3f,%f) \n",x,y);




 }

// Report your answers/
printf("\nMonte Carlo Results (%d Function Calls)\n\n",funCalls);
printf("   Volume Estimate: %15.12f\n", volumeMC);
printf("   Area Estimate:   %15.12f\n\n", areaMC);







}

double depth(double X, double Y, double **A)
{
    double yD,yU,xL,xR,dx,dy,Z;
    double f00,f10,f01,f11;
    int idx,idy;
    idy=(int) floor(Y*64); if (idy>511) idy=511; if (idy<0) idy=0;
    idx=(int) floor(X*64); if (idx>511) idx=511; if (idx<0) idx=0;
    yD=((double) idy)/64; yU=((double) (idy+1))/64; dy=yU-yD;
    xL=((double) idx)/64; xR=((double) (idx+1))/64; dx=xR-xL;
    f00=A[idy][idx]; f10=A[idy][idx+1]; f01=A[idy+1][idx]; f11=A[idy+1][idx+1];
    Z=f00 + (f10-f00)*(X-xL)/dx + (f01-f00)*(Y-yD)/dy + (f11+f00-f01-f10)*(X-xL)*(Y-yD)/dx/dy;

    return Z;


}

void getLakeData(double **A)
{
  double temp;
  FILE *myfile;
  int i,j;

  myfile=fopen("lakeData.txt", "r");

  for(i = 0; i <= DIM; i++)
  {
    for (j = 0 ; j <= DIM; j++)
    {
      fscanf(myfile,"%lf",&temp);
      A[i][j]=temp;

    }

  }


}
