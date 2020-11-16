/*
Adam Stammer ID: 7369992
January 20th, 2018, 7:14pm 
CS250 Assignment #1: Searching and Sorting Arrays
*/
#include <iostream>
#include <fstream>
#include <iomanip>

using namespace std;

int main()
{
    int x = 1;
    int y = 1;
    int counter  = 1;
    while(x > 0) {
        x*= 2;
        counter++;
    }

    cout << counter;

    return 0;
}