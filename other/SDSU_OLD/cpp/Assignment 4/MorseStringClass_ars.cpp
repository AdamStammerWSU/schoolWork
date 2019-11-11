#include <iostream>
#include <iomanip>
#include <cstring>
#include <string>
#include <limits>
#include <vector>

using namespace std;

const int NUM_CHARS = 40;
const int CODE_LENGTH = 11;

void readCString(string &);
void validateCString(string &);
void charToMorse(char, string &);
void CStringToMorse(string, string &);
int binarySearch(int, int, char);

vector<string> morse { " ", "--..--" , ".-.-.-" , "..--.." ,
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
string alphas = " ,.\?0123456789abcdefghijklmnopqrstuv";
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

void readCString(string &data) {
    cout << "Please enter the phrase to convert to morse code: ";
    getline(cin, data);
    if(data.length() > 25) {
        cout << "That is too many characters. Please try again." << endl;
        readCString(data);
    }
    validateCString(data);
}
void validateCString(string &data) {
    int i = 0;
    bool valid = true;
    for(int i = 0; i< data.length(); i++) {
        if(!isalpha(data[i]) && data[i] != '.' && data[i] != ',' && data[i] != '?' && !isdigit(data[i]) && data[i] != ' ' && data[i] != ' ') {
            cout << "Correcting " << data[i] << " at " << i << endl;
            data[i] = ' ';
            valid = false;
        }
    }
    if(!valid) {
        cout << "Undefined characters corrected. View result with suspicion!" << endl;
    }
}

void CStringToMorse(string str, string &mor) {
    int iter = 0;
    string morseCode;
    mor = "";
    for(int i = 0; i < str.length(); i++) {
        charToMorse(str[i], morseCode);
        mor += morseCode + " ";
    }
}

void charToMorse(char c, string &morsey) {
    int index = -1;
    if(bin) {
        index = binarySearch(0, 39, c);
    } else {
        for(int i = 0; i < alphas.length(); i++) {
            if(alphas[i] == tolower(c)) {
                index = i;
            }
        }
    }
    if(c == '?')
        index = 3;
    if(index == -1) {
        cout << index << ": Something messed up (" << c << ")";
    } else {
        morsey = morse[index];
    }
}

void printMorse(string morseCode) {
    cout << "Morse Code: " << morseCode << endl;
}

int main() {
    // char c;
    // cin >> c;
    // cout << (int)c;
    // cout << (int)'?';
    string input;
    readCString(input);
    string morseCode;
    CStringToMorse(input, morseCode);
    printMorse(morseCode);
}
