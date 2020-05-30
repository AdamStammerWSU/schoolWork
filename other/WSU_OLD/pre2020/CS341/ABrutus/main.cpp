#include <iostream>
#include <string>
#include <cmath>

using namespace std;

void incBinStr(char* s, int len) { // counts up in binary
    for(int x = len-1; x >= 0; x--) { //read the string right to left
        if(s[x] != 'd') { // find the first zero from the right
            s[x] = static_cast<char>(s[x]+1); // increment the letter
            if(x < len) { // if it's not the last character (on the right)
                for(int y = x+1; y < len; y++) { // loop through all of the characters to the right
                    s[y] = 'a'; // and zero them out
                }
            }
            x = -1; //break out of for loop
        }
    }
}

int main() {
    char str[5]; //create a cstring to store the bits
    for(int i = 0; i < 4; i++) { // zero out the string
        str[i] = 'a';
    }
    str[4] = '\0';
    cout << str << '\n'; // print it out zero string
    int iterMax = pow(4, 4); // find the amount of total combinations
    for(int i = 0; i < iterMax - 1; i++) {// loop through each possibility except the zero case printed above
        incBinStr(str, 4); // increment the string
        cout << str << '\n'; // and print it
    }
    return 0; // exit
}