/*
Adam Stammer ID: 7369992
January 20th, 2018, 7:14pm 
CS250 Assignment #1: Searching and Sorting Arrays
*/
#include <iostream>
#include <fstream>
#include <iomanip>

using namespace std;

void sortArray(int array[], int size);
void displayPartInfo(int, float, int);
int readInputData(int[], float[], int[]);
void swap(float[], int, int);
void swap(int[], int, int);
void bubbleSort(int[], float[], int[], int);
void listPartsData(int[], float[], int[], int);
int binarySearch(int[], int, int, int);
int multipleLinearSearch(int[], int[], int, int);
int menu(string);

const int MAX_DATA_SIZE = 100;

int main()
{
    //declare parllel storage arrays
    int partNumbers[MAX_DATA_SIZE];
    float partCosts[MAX_DATA_SIZE];
    int partQuantities[MAX_DATA_SIZE];

    // read and store data
    int size = readInputData(partNumbers, partCosts, partQuantities);

    // sort data
    bubbleSort(partNumbers, partCosts, partQuantities, size);

    // defaults to linear searches
    string searchType = "linear";
    
    //error callback
    loopStart:
        int query;
        int optionQuery = 4;
        do {
            
            //present menu and capture input
            optionQuery = menu(searchType);

            //switch cases the various menu items
            switch(optionQuery) {
                //exit when the escape value is given
                case 1: // Search using the current searchType
                    //list part data
                    listPartsData(partNumbers, partCosts, partQuantities, size);
                    // search error callback
                    searchStart:
                    do {
                        //ask user for search query
                        cout << "Please Enter Search Query (-1 to return to options): ";
                        cin >> query;
                        //if escape value, return to menu
                        if(query == -1)
                            break;
                        //throw an error if the query is negative and return to search callback
                        if(query < 0) {
                            cout << "Query entered is invalid. Negatives not allowed.\n";
                            goto searchStart;
                        } else {
                            if(searchType == "binary") { // binary search
                                //search partNumbers for query
                                int queryIndex = binarySearch(partNumbers, 0, size, query);
                                //if nothing is found, inform the user and restart the loop
                                if(queryIndex == -1) { // -1 is only returned if no results were found
                                    cout << "NO MATCHING RESULTS\n";
                                    goto searchStart; //restart search loop
                                } else {
                                    //if something is found display it on screen
                                    cout << "FOUND RESULT\n";

                                    //create parallel arrays of only one item to reuse preexisting listPartsData function
                                    //otherwise you could reprint the column names and then call displayItemData();
                                    int tempNumbers[1] = {partNumbers[queryIndex]};
                                    float tempCosts[1] = {partCosts[queryIndex]};
                                    int tempQuantities[1] = {partQuantities[queryIndex]};
                                    listPartsData(tempNumbers, tempCosts, tempQuantities, 1);
                                }
                            } else { //not binary search, must be linear Search
                                int queryIndexes[MAX_DATA_SIZE];
                                int resultSize = multipleLinearSearch(partNumbers, queryIndexes, query, size);
                                //if there are no results inform the user and restart the search loop
                                if(resultSize == 0) {
                                    cout << "NO RESULTS FOUND\n";
                                    goto searchStart; // restart the search loop
                                } else if (resultSize > 0) { // there is at least one result
                                    cout << "FOUND " << resultSize << " RESULTS\n"; // inform the user
                                    //initialize parallel result arrays
                                    int tempNumbers[resultSize];
                                    float tempCosts[resultSize];
                                    int tempQuantities[resultSize];
                                    // fill parallel result arrays using the result indexes from multipleLinearSearch();
                                    for (int i = 0; i < resultSize; i++) {
                                        tempNumbers[i] = partNumbers[queryIndexes[i]];
                                        tempCosts[i] = partCosts[queryIndexes[i]];
                                        tempQuantities[i] = partQuantities[queryIndexes[i]];
                                    }
                                    //list the resulting part data
                                    listPartsData(tempNumbers, tempCosts, tempQuantities, resultSize);
                                }
                            }
                        }
                    } while (query != -1); // as long as the exit query isn't called
                    break;
                case 2:
                    cout << "Switching to a Linear Search algorithm capabable of finding multiple results...\n";
                    searchType = "linear"; // switch to linear
                    goto loopStart; // go back to option menu loop
                    break;
                case 3:
                    cout << "Switching to a Binary Search algorithm capable of finding only one result...\n";
                    searchType = "binary"; // switch to binary
                    goto loopStart; // go back to option menu loop
                    break;
            }
        } while (optionQuery != 4); // as long as the exit query isn't called

    // end of program
    return 0;
}

//lists out the part data into labled columns
void listPartsData(int partNumbers[], float partCosts[], int partQuantities[], int size) {
    // displays column lables
    cout << right << setw(8) << "Part #" << setw(8) << "Cost" << setw(8) << "Qty" << endl;
    for(int i = 0; i < size; i++) {
        //lists the part data for each stored part
        displayPartInfo(partNumbers[i], partCosts[i], partQuantities[i]);
    }
}

int menu(string searchType) {
    //prints the option menu
            cout << "Options: \n" << left << "     " << "1) Search (" << searchType << ")\n";
            cout << "     " << "2) Linear Search (Multiple Results)\n" << "     " << "3) Binary Search (Single Result)\n";
            cout << "     " << "4) Exit\n\n";

            //ask user for query and store in optionQuery
            cout << "Select An Option Above: ";
            int optionQuery = 4;
            cin >> optionQuery;
            // return user input
            return optionQuery;
}

//reads input data from parts.txt and returns the size of part data
int readInputData(int partNumbers[], float partCosts[], int partQuantities[]) {
    //open parts.txt
    ifstream inFile;
    inFile.open("parts.txt");
    //if the file doesn't open, call an error and exit
    if(!inFile.is_open()) {
        cout << "Failed to open \"parts.txt\"! Closing...";
        //exit(0);
	return 0;
    }
    int size = 0;
    //read in all of the data available and store it in the parallel arrays
    while (size < MAX_DATA_SIZE && inFile >> partNumbers[size] >> partCosts[size] >> partQuantities[size]) {
        size++;
    }
    //close file stream
    inFile.close();
    return size;
}

//displays the information of a part on the screen in columns
void displayPartInfo(int partNumber, float partCost, int partQty) {
    cout << right << setw(8) << partNumber << setw(8) << partCost << setw(8) << partQty << endl;
}

//bubble sort of three arrays based on partNumbers
void bubbleSort(int partNumbers[], float partCosts[], int partQuantities[], int size)
{
    //declaration of temp variables
    bool doSwap;
    int temp1;
    int temp2;
    int temp3;
    do
    {
        //resets loop continuation
        doSwap = false;
        //loops through entire array
        for (int i = 0; i < size - 1; i++)
        {   
            //if the lower index has a higher value than the higher index
            if (partNumbers[i] > partNumbers[i+1])
            {   
                // swaps the two variables in each array
                swap(partNumbers, i, i+1);
                swap(partCosts, i, i+1);
                swap(partQuantities, i, i+1);
                //ensures the loop continues
                doSwap = true;
            }
        }
    }
    while (doSwap); // continue as long as there is still something to swap
}

//recurrsive binary search that returns the index of the query match
int binarySearch(int partNumbers[], int start, int end, int query) {
    //as long as the scope is greater than 0 (there is still something to be searched)
    if (end >= start)
        {
            //find the middle of the array
            int middle = start + (end - start)/2;
    
            // if the middle is the query, return it
            if (partNumbers[middle] == query)  
                return middle;
    
            // if the query is lower than the middle
            if (partNumbers[middle] > query) 
                // start a new binary search in the lower half of the current scope
                return binarySearch(partNumbers, start, middle-1, query);
    
            //if the query is not lower than the middle
            return binarySearch(partNumbers, middle+1, end, query);
        }
    //returns -1 if query is not present in array
    return -1;
}

int multipleLinearSearch(int partNumbers[], int resultsArray[], int query, int size) {
    int results[size];
    int resultSize = 0;
    for(int i = 0; i < size; i++) {
        if(partNumbers[i] == query) {
            resultsArray[resultSize++] = i;
        }
    }

    /*
    int shrunkResults[resultSize];
    for(int i = 0; i < resultSize; i++) {
        shrunkResults[i] = results[i];
    }
    resultsArray = shrunkResults;
    */
    return resultSize;
}

//swaps two elements within an integer array
void swap(int parts[], int indexOne, int indexTwo) {
    //stores first indexed value in temp
    int temp = parts[indexOne];
    //stores second index value in the first index
    parts[indexOne] = parts[indexTwo];
    //sets the second index value to temp
    parts[indexTwo] = temp;
}
//swaps two elements within a float array
void swap(float parts[], int indexOne, int indexTwo) {
    // see swap(int[], int, int) for comments
    int temp = parts[indexOne];
    parts[indexOne] = parts[indexTwo];
    parts[indexTwo] = temp;
}
