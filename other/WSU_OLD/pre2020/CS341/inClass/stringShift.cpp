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

int strLen = 50;

void shiftRight(char *input, char *output) {
    int len = 6;
    char last = input[len - 1];
    for(int i = 1; i < len; i++) {
        output[i]= input[i-1];
    }
    output[0] = last;
    output[len] = '\0';
}

int main() {
    char input[strLen], output[strLen];
    // cin >> input;
    strcpy(input, "Howdy!");

    cout << input << "\n";
    shiftRight(input, output);
    for(int i = 0; i < 5; i++) {
        shiftRight(input, output);
        cout << output << "\n";
        shiftRight(output, input);
        cout << input << "\n";
    }
    return 0; // exit
}