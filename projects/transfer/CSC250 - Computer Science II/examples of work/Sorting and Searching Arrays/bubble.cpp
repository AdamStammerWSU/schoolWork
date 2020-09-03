#include <iostream>


using namespace std;

void sortArray(int array[], int size);
void printArray(int a[], int asize);

int main()
{
    int a[] = {3, 2, 9, 44, 3, 3, 8, 9, 2};
    int asize = 9;

    printArray(a, asize);

    sortArray(a, asize);

    printArray(a, asize);

    return 0;
}

void printArray(int a[], int asize) {
    cout << "Array: {";
    for(int i = 0; i < asize; i++) {
        cout << a[i] << " ";
    }
    cout << "}";
}

void sortArray(int a[], int asize)
{
    bool doSwap;
    int temp;
    do
    {
        doSwap = false;
        for (int i = 0; i < asize - 1; i++)
        {
            if (a[i] > a[i+1])
            {
                temp = a[i];
                a[i] = a[i+1];
                a[i+1] = temp;
                doSwap = true;
            }
        }
    }
    while (doSwap);
}
