#include <iostream>
#include <string>
#include <cmath>

using namespace std;

void incBinStr(char* s, int len) { // counts up in binary
    for(int x = len-1; x >= 0; x--) { //read the string right to left
        if(s[x] == '0') { // find the first zero from the right
            s[x] = '1'; // turn it into a zero
            if(x < len) { // if it's not the last character (on the right)
                for(int y = x+1; y < len; y++) { // loop through all of the characters to the right
                    s[y] = '0'; // and zero them out
                }
            }
            x = -1; //break out of for loop
        }
    }
}

int main() {
    cout << "How many bits will there be?: ";
    int bitCount = 0;
    cin >> bitCount; // get the amount of bits
    char str[bitCount + 1]; //create a cstring to store the bits
    for(int i = 0; i < bitCount; i++) { // zero out the string
        str[i] = '0';
    }
    str[bitCount] = '\0';
    cout << str << '\n'; // print it out zero string
    int iterMax = pow(2, bitCount); // find the amount of total combinations
    for(int i = 0; i < iterMax - 1; i++) {// loop through each possibility except the zero case printed above
        incBinStr(str, bitCount); // increment the string
        cout << str << '\n'; // and print it
    }
    return 0; // exit
}