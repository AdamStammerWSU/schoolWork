#include <iostream>
#include <iomanip>
#include <string>
#include <fstream>

using namespace std;

const string levelNames[] = {"DEBUG", "WARNING", "ERROR"};

void displayPrompt(const string[], int, string &);

class Logger {
	enum LEVELS {
		DEBUG, WARNING, ERROR, SIZE
	};
	public:
		static void log(int warningLevel, string message) {
			cout << levelNames[warningLevel] << ": " << message << endl;
		}
	private:
		BitParser() {}
};

int main() {
	
	return 0;
}

int displayPrompt(const string options[], int nOptions, string &input) {
	cout << endl << endl; //seperate from previous text stream
	for(int i = 0; i < nOptions; i++) { // print out the options
		cout << right << setw(2) << i+1 << ". " << options[i] << endl;
	}
	cout << options[nOptions] << ": "; // prompt for input
	getline(cin, input); // read input
	bool digit = true; // initialize validation variables
	bool alpha = true;
	for (int i = 0; i < input.length(); i++) {
		if(!(isdigit(input[i]) || input[i] == '-' || input[i] == '.')) { // check each character for digit and alpha
			digit = false;
		}
		if(!(isalpha(input[i]))) {
			alpha = false;
		}
	}
	if(digit && !alpha) // only digits
		return 1;
	else if(!digit && alpha) // only alphas
		return 0;
	return -1; // both or neither
}


