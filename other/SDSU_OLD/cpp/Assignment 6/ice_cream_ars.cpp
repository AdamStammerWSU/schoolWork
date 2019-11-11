/*
	Adam Stammer
	CS 250 H, SDSU
	April 2nd, 2018
*/
#include <iostream>
#include <iomanip>
#include <string>
#include <fstream>
#include <cstring>

using namespace std;

const int NAME_SIZE = 51;
const string mainMenu[] = {"Add a Flavour", "List Available Flavours", "Search Flavours", "Calculate Stock Value", "Modify Existing Item", "Clear Inventory Record", "Exit", "Please Select an Option"};
const string levelNames[] = {"DEBUG", "WARNING", "ERROR"};
const string IN_ERROR = "That is not a valid option. Please try again.\n";
const bool DEBUG = false; // set to true to enable debug messages (also see threshold in Logger class)

struct IceCream {
	char flavour[NAME_SIZE];
	float quantity;
	float price;
};

enum MENU_OPTION {ADD=1, LIST, SEARCH, TOTAL, MODIFY, CLEAR, EXIT, COUNT_P1};

void displayFlavourData(IceCream &); // reads the next IceCream data from the file and prints it on screen
void modifyItem(fstream &, bool); // modifies the next IceCream item in the file if bool if false, otherwise appends a new IceCream item
int listFlavours(fstream &, bool); // reads all of the IceCream items from the file and prints the data on the screen, as solection list as specified
				   // returns the amount of flavours read
void displayStockValue(fstream &); // calculates the monetary value of all on hand IceCream and prints it to the screen
int displayPrompt(const string[], int, string &); // displays the contents of the array, of the given size, as a menu and prompts user for input stored in string
										  // returns value based on input type (0 => string, 1 => int, -1 => combo or failure)
void clearFile(fstream &, string); // clears the content of the file; destroys the stock record
void searchFlavours(fstream &); // prompts the user for an item search
void showStreamState(fstream &); // debugs the state of the given file stream


class Logger { // experimenting with "static classes", I may add file based logging to this later
	public:
		enum LEVEL { // defines importance of error
			DEBUG, WARNING, ERROR, SIZE
		};
		static const LEVEL threshold = ERROR; // sets threshold to report
		static void log(int warningLevel, string message) {
			if(warningLevel <= threshold && DEBUG) // only report while debugging and below threshold
				cout << levelNames[warningLevel] << ": " << message << endl;
		}
	private:
		Logger() {} // make it uninitializable (static) by hiding the constructor
};

int main() {
	string fileName = "ice_cream.dat";
	cout << fixed << setprecision(2); // set proper formatting
	fstream file(fileName.c_str(), ios::in | ios::binary); // open file in in mode
	if(!file) { // see if it opened (exists)
		file.close();
		file.open(fileName.c_str(), ios::out | ios::binary); // open it again in out to create it
	}
	file.close();
	file.open(fileName.c_str(), ios::out | ios::in | ios::binary); // open it again in proper in, out, binary mode


	if(!file) { // if it still fails, close
		Logger::log(Logger::ERROR, "Filed to open " + fileName + ". Closing...");
		return -1;
	}
	string input = "";// used to store user input
	int value = -1; // store data input type (-2, -1, 0, 1)
	while(value != 1) {// until the user enters a number
		value = displayPrompt(mainMenu, 7, input); // prompt mainmenu and store response in input
		if(value == 1 && stoi(input) < 8 && stoi(input) > 0) { // valid integer input
			switch(stoi(input)) {
				case ADD: // add a flavour
					modifyItem(file, true);
					break;
				case LIST: // list available flavours
					listFlavours(file, false);
					break;
				case SEARCH: // search flavours
					searchFlavours(file);
					break;
				case TOTAL: // calculate stock values
					displayStockValue(file);
					break;
				case MODIFY:
					modifyItem(file, false);
					break;
				case CLEAR: // clear inventory record
					clearFile(file, fileName);
					break;
				case EXIT: // exit
					cout << "Have a nice day!" << endl;
					file.close();
					return 0;
					break;
			}
			value = -5;
		} else { // invalid option
			cout << IN_ERROR;
		}
		value = -5; // reset for loop
	}

	return 0;
}

void displayFlavourData(IceCream &tempFlav) { 
		cout << "\t\t--------------------------------------------------------\n"; // print the info
		cout << "\t\t" << left << setw(25) << "Flavour: " << tempFlav.flavour << endl; // stored in the IceCream
		cout << "\t\t" << left << setw(25) << "Quantity Available: " << tempFlav.quantity << " .lbs\n";
		cout << "\t\t" << left << setw(24) << "Price: " << "$" << fixed <<  setprecision(2) << tempFlav.price << endl;
		cout << "\t\t--------------------------------------------------------\n"; // print the info
}

void modifyItem(fstream &file, bool newF) {
	string choice[] = {"Please Selected a Flavour (By Number)"};
	string input ="";
	int value = -5;
	int spot = -1; // used to determine stored structure location (-1 is end, n IceCream structs otherwise)
	file.clear(); // clear error state
	if(!newF) { // we are modifying
		int count = listFlavours(file, true); // print the flavor selection list and store the count
		file.clear(); // clear error state
		Logger::log(Logger::DEBUG, "Count: " + to_string(count) + "\n"); // log count
		if(count > 0) { // there are items saved
			while(value != 1) { // wait for integer
				value = displayPrompt(choice, 0, input); // prompt for selection
				if(value == 1) { // if integer
					spot = stoi(input) - 1; // store value in spot
					Logger::log(Logger::DEBUG, "Spot: " + to_string(count) + "\n"); //log spot
				} else { // invalid input
					cout << IN_ERROR;
					value = -5; // reset loop
				}
			}
		} else { // no items to modify
			cout << "No existing files. Adding new entry." << endl;
			newF = true; // switch to new flavour mode
			spot = -1;
		}
	}
	if(spot != -1) {
		file.seekg(spot*sizeof(IceCream), ios::beg);// go to selected ice cream slot
		file.seekp(spot*sizeof(IceCream), ios::beg);
	} else {
		file.seekp(0L, ios::end); // new item, goto end
		file.seekg(0L, ios::end);
	}
	IceCream tempFlav = {"", 0, 0}; // temperary IceCream to read into
	cout << "Please Enter the Information." << endl;
	if(!newF) { // if modifying
		cout << "Return to leave unchanged." << endl;
		file.read(reinterpret_cast<char *>(&tempFlav), sizeof(tempFlav)); // read seletion
		Logger::log(Logger::DEBUG, "Modifying: "); // log read flavour
		if(DEBUG)
			cout <<  tempFlav.flavour;
		file.seekg(spot * sizeof(IceCream), ios::beg);
		file.seekp(spot * sizeof(IceCream), ios::beg); // back up one item (the one you just read)
	}
	string flavour[] = {"Flavour Name"};
	string quantity[] = {"Quantity (lbs.)"};
	string price[] = {"Price"};
	value = -5;
	while(!(value == 0 || value == -2)) { // wait for string or empty input
		value = displayPrompt(flavour, 0, input);
		if(value == 0) { //  change the name
			strcpy(tempFlav.flavour, input.c_str());
		} else {
			cout << IN_ERROR;
		}
	}
	value = -5; // reset for continued input
	while(!(value == 1 || value == -2)) { // wait for int or empty input
		value = displayPrompt(quantity, 0, input);
		if(value == 1) { // change the qty
			tempFlav.quantity = stof(input);
		} else {
			cout << IN_ERROR;
		}
	}
	value = -5; // reset for continued input
	while(!(value == 1 || value == -2)) { // wait for int or empty input
		value = displayPrompt(price, 0, input);
		if(value == 1) { // change the price
			tempFlav.price = stof(input);
		} else {
			cout << IN_ERROR;
		}
	}
	value = -5; // reset for continued input
	file.write(reinterpret_cast<char *>(&tempFlav), sizeof(IceCream)); // write (potentially) new data to file
}

int listFlavours(fstream &file, bool selList) {
	file.clear(); // clear errors
	file.seekg(0, ios::beg); // start reading from the beginning
	if(DEBUG)
		showStreamState(file); // debug filestate
	IceCream tempFlav = {"TestFlavour", 0, 0}; //temporary storage
	int iter = 0;
	while(file.read(reinterpret_cast<char *>(&tempFlav), sizeof(IceCream))) { // read all of the flavor data
		cout << endl;
		if(!selList) { // if not selection list
			displayFlavourData(tempFlav); // print all info
		} else { // otherwise only print the name
			cout << right << setw(3) << (iter+1) << ": " << tempFlav.flavour << endl;
		}
		iter++;
	}
	if(iter == 0) {
		cout << "No items on record.\n";
	}
	return iter;
}

void displayStockValue(fstream &file) {
	file.clear(); // clear error state
	file.seekg(0, ios::beg); // reset to the beginning of the file
	IceCream temp = {"", 0, 0}; // temperary variable
	float stockValue = 0; // summation variables
	float flavourValue = 0;
	while(file.read(reinterpret_cast<char *>(&temp), sizeof(IceCream))) { // read in all of the variables
		flavourValue = (temp.price * temp.quantity); // add to the flavour sum
		cout << setw(31) << right << temp.flavour << ": $" << setprecision(2) << flavourValue << endl; // and print it
		stockValue += flavourValue; // add to the total sum
	}
	cout << "\t\t\t-------------------\n";
	cout << fixed << setw(31) << right << "Total" << ": $" << setprecision(2) << stockValue << endl; // and print that at the end
	
}

int displayPrompt(const string options[], int nOptions, string &input) {
	cout << endl << endl; //seperate from previous text stream
	for(int i = 0; i < nOptions; i++) { // print out the options
		cout << right << setw(2) << i+1 << ". " << options[i] << endl;
	}
	cout << options[nOptions] << ": "; // prompt for input
	getline(cin, input); // read input
	if(input.length() == 0)
		return -2;
	bool digit = true; // initialize validation variables
	bool alpha = true;
	for (int i = 0; i < input.length(); i++) {
		if((!(isdigit(input[i]) || input[i] == '-' || input[i] == '.')) || (input[i] == '-' && input.length() <= 1)) { // check each character for digit and alpha
			digit = false;
		}
			
		if(!(isalpha(input[i]) || input[i] == ' ' || input[i] == '.')) {
			alpha = false;
		}
	}
	if(digit && !alpha) // only digits
		return 1;
	else if(!digit && alpha) // only alphas
		return 0;
	return -1; // both or neither
}

void searchFlavours(fstream &file) {
	file.clear(); // clear error state
	string promptQuery[] = {"Enter a search term (-1 to exit)"};
	int val = -5;
	string input = "";
	IceCream tempFlav = {0};
	file.seekg(0, ios::beg); // reset to beginning of file
	bool resultFound = false; // if anything has been found yet
	bool c1, c2 = false; // reached end of c string
	char ch1[NAME_SIZE]; // current flavour name
	char *ch2; // user query
	while (!(val == 0 || val == 1)) { // wait for a string
		val = displayPrompt(promptQuery, 0, input); // prompt for a query string
		if(val == 0) {
			delete ch2; // clear user input
			ch2 = new char[input.length()+1]; // allocate memory for it
			strcpy(ch2, input.c_str()); // store their input in the c string
			while(file.read(reinterpret_cast<char *>(&tempFlav), sizeof(IceCream))) { // read all of the files
				int i = 0; // character iterator
				strcpy(ch1, tempFlav.flavour); // copy flavour to cstring
				c1 = c2 = false; // reset end of strings
				while(!(c1 & c2)) { // until end of both cstrings is reached
					if(!c1) { // if not at end
						if(ch1[i] == '\0') // if at end, change bool
							c1 = true;
						ch1[i] = tolower(ch1[i]); // lowercase the character
					}
					if(!c2) { //see if statement above
						if(ch2[i] == '\0')
							c2 = true;
						ch2[i] = tolower(ch2[i]);
					}
					i++; // increase current character
				}

				if(strstr(ch1, ch2) != nullptr) { // compare the cstrings (flavour and query)
					displayFlavourData(tempFlav); // display any matches
					resultFound = true; // log find
				}
			}
			if(!resultFound) { // if nothing is found, say so
				cout << "No results found matching that query.\n\n";
				val = -5; // reset the loop to ask for more input
			}
		} else if(val == 1) { // integer is input
			if(stoi(input) == -1) { // -1 has been entered
				cout << "Returning to main menu.\n\n";
				val = 0;
			} else { // not a valid number
				cout << IN_ERROR; // prompt error
				val = -5; // reset loop
			}
		} else {
			cout << IN_ERROR; // wrong data type
			val = -5; // reset loop
		}
	}
}

void showStreamState(fstream &file) {
	//display the error states of the file stream (debug use only)
	cout << "EOF: " << file.eof() << endl;
	cout << "Good: " << file.good() << endl;
	cout << "fail: " << file.fail() << endl;
	cout << "bad: " << file.bad() << endl;
}

void clearFile(fstream &file, string fileName) {
	int val = -5;
	string input = "";
	string confirm[] = {"Are you sure you wish to clear the data file? This cannot be undone (y/n)"};
	while(val != 0) {
		val = displayPrompt(confirm, 0, input);
		if(val == 0) {
			if(input == "yes" || input == "y") {
				cout << "Clearing the data file...\n\n";
				file.clear(); // clear error state
				file.close(); // close the stream
				file.open(fileName.c_str(), ios::out | ios::binary); // open it in output only mode(clears the file)
				file.close(); // close it
				file.open(fileName.c_str(), ios::out | ios::in | ios::app | ios::binary); // reopen it in valid mode
				file.clear(); // clear potential error states
				cout << "Data file cleared.\n\n";
			} else if(input == "no" || input == "n") {
				cout << "Data file not cleared. Stored data remains intact.\n\n";
			} else {
				cout << IN_ERROR;
				val = -5;
			}
		} else {
			cout << IN_ERROR;
			val = -5;
		}
	}
}
