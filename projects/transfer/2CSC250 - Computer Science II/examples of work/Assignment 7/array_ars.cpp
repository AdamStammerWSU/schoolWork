/*
Adam Stammer
CS250H
April, 2018
Assignment 7
*/

#include <iostream>
#include <iomanip>

#include "NumArray.h"

using namespace std;

const string lines = "------------------------\n";

void printNumData(NumArray num, string header) {
    cout << lines;
    int w = (lines.length() / 2) + (header.length() / 2); // find setw size of text
    cout << setw(w) << right << header << endl; // print the header
    cout << lines; // print more spacing
    num.printData(); // print the num data
}

int main() {
    cout << "Size of the array: "; // print for size
    int size = 0; 
    cin >> size; // store the size
    if(size <= 0) { // if the size is too small, exit
        cout << "That value is too small. Exiting..." << endl;
        return -1;
    }
    NumArray num(size); // initialize NumArray with read size
    cout << "What numbers do you want stored?: " << endl; // prompt for input
    float temp;
    for(int i = 0; i< size; i++) { // loop through each element and read in the data
        cout << "Element " << i << ": ";
        cin >> temp;
        num.setItem(i, temp);
    }
    printNumData(num, "Original Non-Sorted"); // print the data unsorted

    num.sortAscend(); // sort the data
    printNumData(num,"Original Sorted"); // print it again

    NumArray num2(num); // create a copy using the copy constructor
    printNumData(num2, "Copied - Non-Resorted"); // print it as is (unsorted)

    num2.setItem(1, 73345); // change an element
	printNumData(num2, "Copied - Element Changed"); // print the new data

	num2.sortAscend(); // sort it with the new element
    printNumData(num2, "Copied - Resorted"); // print it

    printNumData(num,"Original Sorted"); // print the original to prove it remains untouched

    return 0;
}