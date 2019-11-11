/*
    Adam Stammer
    Array Shuffler
    9/26/2018
*/
#include <iostream>
#include <string>
#include <cmath>
#include <cstring>
#include <random>
#include <ctime>

using namespace std;

void shuffleArray(int array[]) { // shuffle the given array
    int i, j, t, r;
    srand(time(NULL)); // set random seed to the system time
    r = (rand() % 10); // get a random number for looping
    for(int x = 0; x < r + 5; x++) { // loop random times + 5
        i = rand() % 11; // find first index
        j = rand() % 11; // find random second index
        t = array[i]; // temporary storage
        array[i] = array[j]; // swap the values
        array[j] = t;
    }
}

int main() {
    int input[11] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10}; // initialize array
    shuffleArray(input); //shuffle that array
    for(int i = 0; i < 11; i++) {
        cout << input[i] << "\n";
    }
    return 0; // exit
}