/*
    Adam Stammer    
    CS381
    Assignment 0 - mean/median
    9/20/2018
*/

#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <cmath>

using namespace std;

void readData(ifstream &ifstr, vector<int> &v) {
    ifstr.open("input.dat"); // open the data file
    if(!ifstr) { // make sure it succeeds at opening, exit on fail
        cout << "Unable to open file\n"; 
        exit(1);
    }
    int inVal = -1;
    while ((ifstr >> inVal)) { // read in data and store it in the vector
        v.push_back(inVal);
    }
}

void printData(vector<int> v) { // print out all elements of the vector
    for(int i = 0; i < v.size(); i++) {
        cout << v[i] << '\n';
    }
}

void printMenu() { // display the menu options
    cout << "\t1. Display Raw Data\n";
    cout << "\t2. Display Ascending\n";
    cout << "\t3. Display Descending\n";
    cout << "\t4. Display Mean and Median\n";
    cout << "\t5. Quit\n\t";
}
void copyVector(vector<int> &v, vector<int> &w) {
    for(int i = 0; i < v.size(); i++) { // loop through the vector values and copy them over to the other vector
        w.push_back(v[i]);
    }
}
void printMenMed(vector<int> v) {
    float men = 0; // use as sum variable too
    float med = -1; // default median value
    for(int i = 0; i < v.size(); i++) {
        men+=v[i]; // use the men variable to calculate the sum
    }
    men /= v.size(); // calculate the average
    if(v.size() % 2 == 0) { // even size (no middle)
        int mid = floor(v.size()/2.0) - 1; // find bottom of the middle
        med = (v[mid] + v[mid+1]) / 2.0;
    } else {
        med = v[(v.size() / 2)-1]; // middle value if size of v is odd
    }
    cout << "Mean: " << men; // print out the found values
    cout << "\nMedian: " << med << "\n";
}
int main() {
    ifstream inFile;
    vector<int> data, dataA, dataD;
    readData(inFile, data); // read the data to the vector
    copyVector(data, dataA); // make a sortable copy fo the vector
    // copyVector(data, dataD);
    sort(dataA.begin(), dataA.end()); // sort the copies vector
    for(int i = data.size()-1; i>=0; i--) { // reverse sort the other vector
        dataD.push_back(dataA[i]);
    }
    int choice = -1;
    while(choice != 5) { // menu loop
        printMenu();
        cin >> choice;

        switch (choice) {
            case 1: // print raw data
                printData(data);
            break;
            case 2: // print ascended
                printData(dataA);
            break;
            case 3: // print decscended
                printData(dataD);
            break;
            case 4: // calculate and print the median and mean of the data
                printMenMed(data);
            break;
            case 5:
                exit(0); // quit the application
            default:
                cout << "That is not a valid option.\n";
        }
    }
    

    return 0;
}