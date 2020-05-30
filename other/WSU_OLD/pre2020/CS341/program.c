#include <stdio.h>

int main()
{
  int num,total=0;

  printf("Enter a number  ");
  scanf("%d", &num);
  if (num >0) {
    printf("The number is greater than 0 \n");
  }
  else if (num == 0) {
     printf("The number is 0\n");
  }
  else printf("The number is less than 0\n");
  while (num < 1000) {
      num= num * num;
  }
  return 0;
}