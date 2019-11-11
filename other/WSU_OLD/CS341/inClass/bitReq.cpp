/*
    Adam Stammer
    String Shifter
    9/26/2018
*/
#include <iostream>
#include <string>
#include <cmath>
#include <cstring>

using namespace std;

int main() {
    int n = 0;
    cout << "How many values will be stored?: ";
    cin >> n;
    cout << "You will need " << n*32 << " bits to store " << n << " values.\n";
    return 0; // exit
}