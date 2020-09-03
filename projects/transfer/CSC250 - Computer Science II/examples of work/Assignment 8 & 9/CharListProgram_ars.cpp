/*
    Adam Stammer    
    CS250H
    Assignment 8 & 9
    Linked List Storing Characters
*/

#include <iostream>
#include <iomanip>
#include "CharList.h"
#include <cstring>

using namespace std;

int main() {
    CharList clist; // initialize CharList
    cout << "Inserting 'm'\n"; // insert 3 test nodes
    cout << "Inserting 'd'\n";
    cout << "Inserting '0'\n";
    clist.insertNode('m');
    clist.insertNode('d');
    clist.insertNode('0');
    cout << "Displaying List: \n"; // display the list with the testNodes
    clist.displayList();
    cout << "\nDisplaying List in Reverse: \n"; // display it in reverse
    clist.showReverse();
    cout << "\nCurrent List Size: " << clist.lenStr() << endl; //print out the size of the list


    cout << "Appending 'a'\n"; // append 3 more test nodes
    cout << "Appending 'c'\n";
    cout << "Appending 'b'\n";
    clist.appendNode('a');
    clist.appendNode('c');
    clist.appendNode('b');
    cout << "\nDisplaying List: \n"; // display the list afterwards
    clist.displayList();
    cout << "\nCurrent List Size: " << clist.lenStr() << endl; // display the new lenght


    cout << "\nAppending the string 'Book'\n";
    char c[10] = "Book";
    clist.catStr(c); // append the "book" string
    cout << "Displaying List: \n";
    clist.displayList(); // display the list with "book" appended

    cout << "Appending 'y' and 'u'\n";
    clist.appendNode('y'); // append two more test nodes after book
    clist.appendNode('u');

    
    cout << "Displaying List: \n"; // display the list
    clist.displayList();
    
    cout << "Searching for \"Book\" in list\n";
    int pos = clist.findStr(c); // and search for book within the list
    if(pos == -1) 
        cout << "The string was not found.\n";
    else
        cout << "The string was found at position " << pos << ".\n";

    cout << "Searching for \"Bookshelf\" in list\n";
    strcpy(c, "Bookshelf"); // search for bookshelf (which should not be in the list)
    pos = clist.findStr(c);
    if(pos == -1) 
        cout << "The string was not found.\n";
    else
        cout << "The string was found at position " << pos << ".\n";

    strcpy(c, "Book");
    cout << "\nCopying \"Book\" onto list\n"; // copy book over the list after it is cleared
    clist.cpyStr(c);
    cout << "Displaying List: \n"; // display the list both forward and backwards
    clist.displayList();
    cout << "\nDisplaying List in Reverse: \n"; 
    clist.showReverse();

    cout << "Searching for \"Book\" in list\n"; // search for book in the list (pos 0)
    pos = clist.findStr(c);
    if(pos == -1) 
        cout << "The string was not found.\n";
    else
        cout << "The string was found at position " << pos << ".\n";

    return 0;
}