#include <iostream>
#include <iomanip>
#include <cstring>
#include <string>
#include <limits>

using namespace std;

const int NUM_CHARS = 40;
const int CODE_LENGTH = 11;

void readCString(char []);
void validateCString(char []);
void charToMorse(char, char[]);
void readCString(char []);
void CStringToMorse(char [], char []);
int binarySearch(int, int, char);

char morse[NUM_CHARS][CODE_LENGTH] = { " ", "--..--" , ".-.-.-" , "..--.." ,
                            "-----", ".----", "..---", "...--",
                            "....-", ".....", "-....", "--...",
                            "---..", "----.", ".-", "-...",
                            "-.-.", "-..", ".", "..-.",
                            "--.", "....", "..", ".---",
                            "-.-", ".-..", "--", "-.",
                            "---", ".--.", "--.-", ".-.",
                            "...", "-", "..-", "...-",
                            ".--", "-..-", "-.--", "--.."
                          };
char alphas[NUM_CHARS] = " ,.?0123456789abcdefghijklmnopqrstuv";
const bool bin = true;

//recurrsive binary search that returns the index of the query match
int binarySearch(int start, int end, char query) {
    //as long as the scope is greater than 0 (there is still something to be searched)
    if (end >= start)
        {
            //find the middle of the array
            int middle = start + (end - start)/2;
            //cout << "Comparing " << (char)query << " to " << (char)alphas[middle] << endl;
            // if the middle is the query, return it
            if (alphas[middle] == tolower(query))  
                return middle;
    
            // if the query is lower than the middle
            if (alphas[middle] > tolower(query)) 
                // start a new binary search in the lower half of the current scope
                return binarySearch(start, middle-1, query);
    
            //if the query is not lower than the middle
            return binarySearch( middle+1, end, query);
        }
    //returns -1 if query is not present in array
    return -1;
}

void readCString(char data[]) {
    cout << "Please enter the phrase to convert to morse code: ";
    cin.getline(data, 26);
    if(cin.fail()) {
        cout << "That is too many characters. Please try again." << endl;
        cin.clear();
        cin.ignore(numeric_limits<streamsize>::max(), '\n');
        readCString(data);
    }
    validateCString(data);
}
void validateCString(char data[]) {
    int i = 0;
    bool valid = true;
    while(data[i] != '\0') {
        if(!isalpha(data[i]) && data[i] != '.' && data[i] != ',' && data[i] != '?' && !isdigit(data[i]) && data[i] != ' ') {
            cout << "Correcting " << data[i] << " at " << i << endl;
            data[i] = ' ';
            valid = false;            
        }
        i++;
    }
    if(!valid) {
        cout << "Undefined characters corrected. View result with suspicion!" << endl;
    }
}

void CStringToMorse(char str[], char mor[]) {
    int iter = 0;
    char morseCode[7];
    strcpy(mor, "");
    do {
        charToMorse(str[iter], morseCode);
        strcat(mor, morseCode);
        strcat(mor, " ");
        iter++;
    } while (str[iter] != '\0');
}

void charToMorse(char c, char * morsey) {
    int index = -1;
    if(bin) {
        index = binarySearch(0, 39, c);
    } else {
        int iter =0;
        while(alphas[iter] != '\0') {
            if(alphas[iter] == tolower(c)) {
                index = iter;
            }
            iter++;
        }
    }
    if(c == '?')
        index = 3;
    if(index == -1) {
        cout << index << ": Something messed up (" << c << ")";
    } else {
        strcpy(morsey, morse[index]);
    }
}

void printMorse(char morseCode[]) {
    cout << "Morse Code: " << morseCode << endl;
}

int main() {
    char a[26];
    readCString(a);
    char morseCode[26*7];
    CStringToMorse(a, morseCode);
    printMorse(morseCode);
}
