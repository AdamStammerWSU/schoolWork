/*
    Adam Stammer
    Assignment 7 - Class
*/
#include <iostream>
#include <iomanip>
#include "NumArray.h"

using namespace std;

const string BOOLS[] = {"false", "true"}; // used for binary output

NumArray::NumArray(int size) {
    iSize = size; // store the inpt size
    bSorted = false; // not sorted by default
    pNumbers = new int[iSize]; // allocate memory
}
NumArray::NumArray(NumArray &num) {
    iSize = num.size(); // copy size
    bSorted = num.sorted(); // copy sorted state
    pNumbers = new int[iSize]; // allocate new memory
    for(int i = 0; i < iSize; i++) { // and copy the data over
        pNumbers[i] = num.getItem(i);
    }
}

NumArray::~NumArray() {
    delete pNumbers; // clear the memory
}

float NumArray::getItem(int loc) {
    if(loc < iSize && loc >= 0) // verify location exists
        return pNumbers[loc]; // return the value
    else { // if the location does not exist, print error and return 0
        cout << "The requested item read location does not exist.\n";
        return 0;
    } 
}

void NumArray::setItem(int loc, float value) {
    if(loc < iSize && loc >= 0) // verify location exist
        pNumbers[loc] = value; // store value
    else { // if location does not exist
        cout << "The requested item write location does not exist.\n"; // print an error
    }
}

float NumArray::findAvg() {
    float sum = 0; // store the sum
    for(int i = 0; i < size(); i++) {
        sum += pNumbers[i]; // loop through all and add the number to the sum
    }
    return (sum / size()); // divide by size to find average
}

void NumArray::sortAscend() {
    for(int i = 0; i < size() - 1; i++) { // loop through all but the last
        int smallIndex = i; // index the smallest starting with the first
        for(int j = i+1; j < iSize; j++) { // loop through them all
            if(pNumbers[j] < pNumbers[smallIndex]) // if the current one is smaller than the current smallest
                smallIndex = j; // it becomes the current smallest
        }
        float temp = pNumbers[i]; // temp for storage
        pNumbers[i] = pNumbers[smallIndex]; // current equals smallest
        pNumbers[smallIndex] = temp; // smallest equals old current
    }
    bSorted = true; // you're now sorted
}

float NumArray::findMedian() {
    if(size() > 0) { // check for data to check
        if(!sorted()) // if not sorted
            sortAscend(); // sort it
        int h = size() / 2; // middle ceiling
        if(size() % 2 == 0) {// is even 
            return (pNumbers[h] + pNumbers[h-1]) / 2.0; // average of two middle points
        }
        return pNumbers[h]; // middle point
    } else {
        cout << "Data is empty." << endl; // error message
    }
}

void NumArray::printData() {
    cout << "Array Size: " << iSize << endl; // print size
    cout << "Is Sorted: " << BOOLS[bSorted] << endl; // print sort state
    if(sorted()) { // if sorted
        cout << "Average: " << findAvg() << endl; // print average
        cout << "Median: " << findMedian() << endl; // print median
    }
    cout << "\tValues" << endl; // print values
    cout << "\t------" << endl;
    for(int i = 0; i < iSize; i++) { // in a loop
        cout << "\t   " << pNumbers[i] << endl; // with spacing
    }
}
