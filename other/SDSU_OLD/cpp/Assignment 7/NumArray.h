#ifndef NUMARRAY_H
#define NUMARRAY_H

using namespace std;

class NumArray {
    private:
        int * pNumbers; // the array to be created/stored
        int iSize; // the size of the array
        bool bSorted; // the sort status of the array
    public:
        NumArray(int); // dynamically allocates memory for the array and initializes the status variables
        NumArray(NumArray &); // copies the information from a passed NumArray
        ~NumArray(); // deletes the allocated array

        void setItem(int loc, float value); // set the data at the given
                            // location to the given value
        float getItem(int loc); // reads the data at
                            // the given location and returns it. If it doesn't exist, -1 is returned
        bool sorted() {return bSorted;} //returns the sort status of the array
        int size() {return iSize;} // returns the size of the array
        float findAvg(); // finds the average of the array
        void sortAscend(); // sorts the array in ascending order (selection sort)
        float findMedian(); // finds the median of the data
        void printData(); // prints the stored data and relevant stats
};
#endif
