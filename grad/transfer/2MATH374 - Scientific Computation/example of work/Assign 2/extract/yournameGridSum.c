// Naming Convention:  Same as CSC Server
//      First 7 or less letters of last name followed by first name letter.
//        For example,  Matt Biesecker would turn in  "bieseckmGridSum.c"
//                      Sandra Poe would turn in    "poesGridSum.c"

#include <stdio.h>
#include <math.h>
#include <time.h>
int main(void)
{
  int row,col,N;
  float x,y, width, sum1=0, sum2=0, rowSum, trueAnswer=2.0;
  float result1,result2,relErr1, relErr2;
  clock_t begin, end;
  double t1,t2;
  printf("Give me a value for N: ");
  scanf("%d",&N);
  width= 1/(float) N;

  begin=clock();
  for(row=1;row<=N;row++)
    {
      for(col=1;col<=N;col++)
        {
           sum1=0;   // WRONG:  Put in correct code
        }
    }
  end=clock();
  t1=(double) (end -begin) /CLOCKS_PER_SEC;

  begin=clock();
  for(row=1;row<=N;row++)
  {
      rowSum=0;
      y=(row-0.5)*width;
      for(col=1;col<=N;col++)
       {
            //  PUT in correct code
       }
      sum2=0;  //  // WRONG:  Put in correct code
   }
  end=clock();
  t2=(double) (end - begin) /CLOCKS_PER_SEC;

  result1=3*width*width*sum1;
  result2=3*width*width*sum2;
  relErr1=fabs(trueAnswer-result1)/fabs(trueAnswer);
  relErr2=fabs(trueAnswer-result2)/fabs(trueAnswer);
  printf("Method 1 (Nested Loop): \n");
  printf("    Result:    %.8f\n ", result1);
  printf("    Rel Error: %.3e\n ", relErr1);
  printf("    Run Time:  %.4e\n", t1);
  printf("Method 2 (Nested Loop): \n");
  printf("    Result:    %.8f\n ", result2);
  printf("    Rel Error: %.3e\n ", relErr2);
  printf("    Run Time:  %.4e\n", t2);

  return 0;
}
