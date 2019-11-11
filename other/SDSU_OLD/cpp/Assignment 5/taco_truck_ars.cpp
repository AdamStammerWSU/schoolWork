/*
		Adam Stammer
		3/18/2018
		CS250 - Assignment 5
*/
#include <iostream>
#include <iomanip>
#include <string>
#include <fstream>
#include <cstdlib>
#include <vector>

using namespace std;

enum ItemType {ENTREE, DRINK, DESSERT, NUM_TYPES};

const string ITEM_TYPES[] = {"ENTREE", "DRINK", "DESSERT", "Please Select a Type"};
const int MENU_SIZE = 15;
const string INVALID = "Not a valid option. Please try again.\n";
const string BAR = "----------------------------------------------";

struct MenuItem {string name; ItemType type; float cost; int qty;};
struct Check {float total; float tax; float tip;};

int printMenu(const string[], int, string &); // prints the given menu to the screen, with n options, and prompts the user using string[n],
											  // stores input in string, returns {-1=invalid, 0=string, 1=int}
int readMenuItemsFromFile(MenuItem []); //reads the menuitems from the file taco_menu.txt and stores them in the given array
void printItemInfoByType(MenuItem [], ItemType); // menu option 1 - prints the item info of all the items matching the given itemtype
void printItemInfo(MenuItem, bool, bool, bool); // prints the info of the given menuitem, full cost or unit cost may be printed
												//only prints itemType and qty if specified
void addItemToBill(vector<MenuItem> &, MenuItem); //asks user for quantity and adds the given item(s) to the vector
int searchItems(MenuItem[], MenuItem[], string);//searches the first array for the given string and fills the second array with
												//the results, returns the quantity of items stored in results
void printTotalCost(MenuItem[]); // prints the total cost of the items in the array
void printBill(MenuItem[], vector<MenuItem> &, bool); //prints the bill, if final fills array with revenue logs and clears bill
void printTotalByType(MenuItem[], ItemType); // calculates the total cumulative sales of the given item type
void calcTotalBill(MenuItem[], int, Check &); // calculates the total cost and tax/tip of items in the array and fill the Check with it
void sortMenu(MenuItem []); // selection sorts the menu by itemType {entrees, drinks, desserts}

int main() {
	MenuItem menu[MENU_SIZE];//the available food items, stores amount sold in qty
	vector<MenuItem> bill;//the currently selected items to be purchased, stores amount selected in qty
	int x = readMenuItemsFromFile(menu); // loads in the menu from the file
	if(x == -1) { // file read failed
		cout << "Failed to open file......" << endl << "closing now" << endl;
		return -1;
	}
	sortMenu(menu);
	bool running = true;
	int iIn = -1;//ui user choice (1-6)
	const string mainMenu[] = {"List Available Items", "Add Item(s)", "Print Current Total", "Finalize Bill", "Calculate Revenue By Type", "Clear Current Selection(s)", "Exit", "Please Select An Option"};
	const string addItemMenu[] = {"Add By Number", "Search By Name", "Please Select a Method (-1 to return)"};
	const string pickItem[] = {"Enter query"};
	const string correctItem[] = {"Would you like to add this item (y/n)?"};
	const string confirm[] = {"Are you sure you want to clear the current selection(s) (yes/no)?"};
	string input = "";
	

	while(running) {
		int val = -10;
		while(val != 1) { // until the user enters an integer
			val = printMenu(mainMenu, 7, input); // print the menu
			if(val != 1) // request retry and reprint menu
				cout << INVALID;
		}
		val = -1;
		iIn = stoi(input); // get numerical input

		//pre-initialzation to avoid cross initialization of future switch-case
		string itemNames[MENU_SIZE+1] = {};
		MenuItem results[MENU_SIZE] = {};
		bool adding = true;
		ItemType queryType;
		Check revenue;
		//

		switch(iIn) { // main menu input
			case 1: // Print Item Info By Type
				for(int i = 0; i < NUM_TYPES; i++) {
					val = (BAR.length() / 2) + ITEM_TYPES[i].length() / 2 ; // find the setw value to center the heading
					cout << BAR << endl << right << setw(val) << ITEM_TYPES[i] << endl << BAR << endl;
					printItemInfoByType(menu, static_cast<ItemType>(i)); // print item info by the type chosen
				}
				val = -1; // reset menu
				break;
			case 2: // Add Item to Bill
				while(val != 1) { // while user still hasn't entered a number
					val = printMenu(addItemMenu, 2, input); // print the addItemMenu
					if(val == 1) { // if they enter a number
						iIn = stoi(input); // store input as int
						if(iIn < -1 || iIn > 2 || iIn == 0) {
							cout << INVALID;
							val = -1;
						}
					} else { //otherwise, prompt for retry
						cout << INVALID;
					}
				}
				val = -1; // reset menu input type
				switch(iIn) { // addItemMenu input
					case 1: // add by number
						
						for(int i = 0; i < MENU_SIZE; i++) { // loop through every menu item
							itemNames[i] = menu[i].name; // fill itemNames with the names
						}
						itemNames[MENU_SIZE] = "Enter the Item Number to Add (-1 to return)"; // add user prompt
						adding = true; // loop this menu until they enter -1
						while(val != 1 || adding) { // still adding food to selection, or failed to enter valid option
							val = printMenu(itemNames, MENU_SIZE, input); // display item options and prompt for input
							if(val == 1) { // valid input
								iIn = stoi(input); // convert to int
								if(iIn == -1) { // -1 to quit
									adding = false;// quit
								} else if(iIn > 0 && iIn < MENU_SIZE) { // if valid range
									addItemToBill(bill, menu[iIn-1]); // add the item to the bill
								} else {
									cout << INVALID; // prompt for retry
								}
							} else {
								cout << INVALID;
							}
						}
						break;
					case 2: //search by name
						while(val != 0) {
							val = printMenu(pickItem, 0, input); // ask for query
							if(val == 0) { // if they entered a string
								
								val = searchItems(menu, results, input); // search the item names for that string
								if(val > 0) { // if there is a result
									cout << val << " result(s) found.\n";
									if(val == 1) { // only one result
										cout << "Only one result:\n";
										printItemInfo(results[0], false, true, false); // tell them what it is
										val = -1; // reset val
										while(val != 0) { // wait for string
											val = printMenu(correctItem, 0, input); // ask if they want it (yes/no)
											if(val == 0) { // string entered
												for(int i = 0; i < input.length(); i++)
													input[i] = tolower(input[i]); // to lowercase the input string
												if(input == "y" || input == "yes") { // if yes
													addItemToBill(bill, results[0]); // add it to bill
												} else if(input == "n" || input == "no") { // if no,
													cout << "Item not added.\n"; // don't
													val = 0; 
												} else {
													cout << INVALID; // otherwise, not valid input
													val = -1; // make sure the while loop continues
												}
											}
										}
									} else { // multiple results
										for(int i = 0; i < val; i++) {
											itemNames[i] = results[i].name; // fill array with item names
										}
										itemNames[val] = "Which item would you like (-1 for none)";
										iIn = 0; // used as validation for next menu
										while(iIn != 1) { // wait for int input
											iIn = printMenu(itemNames, val, input); // choose which item to add
											if(iIn == 1) {// entered an int
												iIn = stoi(input);
												if(iIn > -2 && iIn != 0 && iIn < val+1) { // number is within range
													if(iIn == -1) { // -1 to return
														iIn = 1; // finish loop
													} else {
														addItemToBill(bill, results[iIn-1]); // add item to bill
														iIn = 1; // and finish loop
													}
												} else {
													cout << INVALID; // invalid input
													iIn = 0; // continue loop
												}
											}
										}
									}
								} else {
									cout << "0 results found.   :(\n";
								}
								val = 0; // make sure the while loop ends
							} else {
								cout << INVALID; // invalid input
							}
						}
						break;
					default:
						cout << "This should never be seen. Please contact your system administrator for assistance.\n";
						// this should never be reached;
						break;
				}
				break;
			case 3: // Print Current Total
				printBill(menu, bill, false); // prints out the currently selected items and the resulting totals
											  // does not clear selections
				break;
			case 4: // Finalize the Sale and Print the bill
				printBill(menu, bill, true); // prints out the currently selected items and the resulting totals
											 // clears the current selections
				break;
			case 5: // calculate and print the total revenue by type
				val = -1;
				while(val != 1) { // continue until number is entered
					val = printMenu(ITEM_TYPES, NUM_TYPES, input); // display itemType menu
					if(val == 1) { // if int entered
						iIn = stoi(input); // convert to int
						if(iIn > 0 && iIn < 4) { // validate range
							queryType = static_cast<ItemType>(iIn-1); // cast input to ItemType
							val = 0; // using val to count the number of results to save memory
							for(int i = 0; i < MENU_SIZE; i++) { // loop through available items
								if(menu[i].type == queryType && menu[i].qty > 0) { // if itemType equals search type and quantity is greater than 0
									results[val] = menu[i]; // reuse existing array to save memory
									val++; // increase result counter
								}
							}
							calcTotalBill(results, val, revenue); // calculate the bill for the valid items
							cout << "Total Revenue for $" << ITEM_TYPES[iIn-1] << ": " << revenue.total << endl; // display result
							val = 1; // reset menu and exit loop
						} else {
							cout << INVALID; // prompt for retry
							val = -1; // reset menu loop
						}
					} else {
						cout << INVALID; // prompt for retry
					}
				}
				val = -1; // reset menu input
				break;
			case 6:
				val = -1;
				while(val != 0) { // wait for string
					val = printMenu(confirm, 0, input); // ask if they want it (yes/no)
					if(val == 0) { // string entered
						for(int i = 0; i < input.length(); i++)
							input[i] = tolower(input[i]); // to lowercase the input string
						if(input == "y" || input == "yes") { // if yes
							bill = {};// clear the bill
							cout << "\nSelection(s) Cleared.\n"; 
							val = 0; 
						} else if(input == "n" || input == "no") { // if no,
							cout << "\nSelections Not Cleared. Bill is unchanged.\n"; // don't clear the bill
						} else {
							cout << INVALID; // otherwise, not valid input
							val = -1; // make sure the while loop continues
						}
					}
				}
				break;
			case 7: // exit the program
				cout << "Closing..."<< endl;
				running = false; // close the program
				break;
			default: // code should never be reached
				cout << INVALID;
				break;
		}
		cout << endl << endl; // seperate next menu display from current one
	}
	
	return 0;
}

void sortMenu(MenuItem menu[]) { // selection sort
	int min; // minimum variable
 
   	//loop through the menu
    for (int i = 0; i < MENU_SIZE - 1; i++)
    {
        
        min = i; // find the minumum
        for (int j = i+1; j < MENU_SIZE; j++)
          if (menu[j].type < menu[min].type) // by type
            min = j; 
 
        
        MenuItem temp = menu[i];
		menu[i] = menu[min]; // swap elements 
		menu[min] = temp;
    }
}

int searchItems(MenuItem menu[], MenuItem results[], string query) {
	int res = 0; // how many results
	int pos = string::npos; // where is the match
	string lowcName = "";
	for (int i = 0; i < MENU_SIZE; i++) { // loop through the items
		for(int j = 0;j < menu[i].name.length(); j++) {
			lowcName += tolower(menu[i].name[j]); // get the lowercase name of the item
		}
		pos = lowcName.find(query); // search for query
		if(pos != string::npos) { // if there is a result
			results[res] = menu[i]; // add the item to the results list
			res++; // increment result count
		}
		lowcName = ""; // reset the name
	}
	return res; // return the count
}

void addItemToBill(vector<MenuItem> &bill, MenuItem mi) {
	string quan[] = {"How many would you like?"};
	string input = "";
	int val = -1; // validation variable
	int qty = -1; // quantity requested
	while(val != 1) { // wait for int
		val = printMenu(quan, 0, input); // ask user for quantity
		if(val == 1) { //if they enter a number
			qty = stoi(input); // convert it to int
			if(qty < 0) { // if it's too small
				cout << "Must be a positive number.\n"; // tell them
				val = -1; // and repeat loop
			}
		} else {
			cout << INVALID; // invalid input
		}
	} 

	bool newItem = true; // item is new by default
	for(int i = 0; i < bill.size(); i++) { // loop through all items
		if(bill[i].name == mi.name) { // if addItem is already on the list
			newItem = false; // it's not longer new
			bill[i].qty+=qty; // increase quantity
			cout << "Increasing item quantity\n"; // prompt success
		}
	}
	if(newItem) { // if it is still new (not on list yet)
		mi.qty = qty; // increase quantity of local item (does carry over to menu)
		bill.push_back(mi); // add it to the bill
		cout << qty << " " << mi.name << "(s) added to bill.\n"; // prompt success
	}

}

void calcTotalBill(MenuItem bill[], int size, Check &check) {
	check = {}; // clear out check
	for (int i = 0; i < size; i++) { // loop through the whole check
		check.total += (bill[i].cost * bill[i].qty); // calculate the total
	}
	check.tax = check.total * 0.07; // calc tax
	check.tip = check.total * 0.15; // calc tip
}

void printBill(MenuItem menu[], vector<MenuItem> &bill, bool finalSale) {
	Check check; // temp check
	cout << "\n\n";
	calcTotalBill(&(bill[0]), static_cast<int>(bill.size()), check); // calc bill using temp check and vector
	for(int i = 0; i < bill.size(); i++) { // loop through the bill
		if(bill[i].qty > 0)
			printItemInfo(bill[i], true, true, true); // print the item info
		if(finalSale) { // if the sale is final
			for(int j = 0; j < MENU_SIZE; j++) { // loop through menu items
				if(bill[i].name == menu[j].name) { // and increment qty for revenue
					menu[j].qty += bill[i].qty; // add the new quantites of items to the revenue log 
				}
			}
		}
	}
	//diplay calculated costs
	cout << fixed << setprecision(2) << right << setw(20) << "Subtotal: $" << check.total << endl << setw(20) << "Tax: $"
		 << check.tax << endl << setw(20) << "Total: $" << (check.total+check.tax) << endl << setw(20) << "Total /w 15% Tip: $" 
		 << (check.total+check.tax+check.tip) << endl;
	
	if(finalSale) { // if final, clear selection and thank user
		cout << BAR;
		cout << "\nThank You for your patronage. Have a nice day!\n";
		cout << BAR << endl;
		bill = {}; // reset bill
	}
}

void printItemInfoByType(MenuItem menu[], ItemType itemType) {
	MenuItem mi; // temp menuItem
	for(int i = 0; i < MENU_SIZE; i++) { // loop through menu
		if(menu[i].type == itemType) { // if the type is correct
			cout << right << setw(2) << i+1 << ": "; // print the item info
			printItemInfo(menu[i], false, false, false);
		}
	}
}

void printItemInfo(MenuItem mi, bool fullCost, bool printType, bool printQty) {
	if(printType) { //only if printType is wanted
		cout << ITEM_TYPES[mi.type] << ": ";
	}
	float cost = mi.cost;
	if(fullCost) // should we print the full cost or just the unit cost
		cost *= mi.qty;
	cout << left << setw(18) << mi.name << "  Cost: $" << fixed << setprecision(2) << cost; // print the item info
	if(printQty) // and quantity if specified
		cout << "  Qty: " << mi.qty;
	cout << endl; 
}

int readMenuItemsFromFile(MenuItem menuItem[MENU_SIZE]) {
	ifstream file;
	file.open("taco_menu.txt");// open the file
	if(file.fail()) { // if it fails, return escape value
		file.close();
		return -1;
	} else {
		MenuItem i = {}; //otherwise, create temp variables
		int iter = 0;
		string itemName = "";
		int iType = 0;
		//and read in the data
		/*	name
			type(0-2) cost	*/
		while(getline(file, i.name) && file >> iType && file >> i.cost) {
			i.type = static_cast<ItemType>(iType); // cast the type number
			menuItem[iter] = i; // store the menu
			iter++; // increase iteration
			file.ignore(); // ignore the newline left by extraction op
		}
	}
	file.close(); // done reading, close stream
	return 0; // return success value
}

//prints the options in a numbered menu and the final string in the array as a user input prompt
//return 0 if the input is a string, 1 if a number, and -1 otherwise (both alpha and number, or special characters)
int printMenu(const string options[], int nOptions, string &input) {
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
