
#include <iostream>
#include "CharList.h"
using namespace std;


void CharList::appendNode(char c)
{
   ListNode *newNode;  // To point to a new node
   ListNode *nodePtr;  // To move through the list

   // Allocate a new node and store num there.
   newNode = new ListNode;
   newNode->letter = c;
   newNode->next = nullptr;

   // If there are no nodes in the list
   // make newNode the first node.
   if (!head)
      head = newNode;
   else  // Otherwise, insert newNode at end.
   {
      // Initialize nodePtr to head of list.
      nodePtr = head;

      // Find the last node in the list.
      while (nodePtr->next)
         nodePtr = nodePtr->next;

      // Insert newNode as the last node.
      nodePtr->next = newNode;
   }
}

void CharList::displayList() const
{
   ListNode *nodePtr;  // To move through the list

   // Position nodePtr at the head of the list.
   nodePtr = head;

   // While nodePtr points to a node, traverse
   // the list.
   while (nodePtr)
   {
      // Display the letter in this node.
      cout << nodePtr->letter << endl;

      // Move to the next node.
      nodePtr = nodePtr->next;
   }
}

void CharList::insertNode(char c)
{
   ListNode *newNode;					// A new node
   ListNode *nodePtr;					// To traverse the list
   ListNode *previousNode = nullptr;	// The previous node

   // Allocate a new node and store num there.
   newNode = new ListNode;
   newNode->letter = c;
   
   // If there are no nodes in the list
   // make newNode the first node
   if (!head)
   {
      head = newNode;
      newNode->next = nullptr;
   }
   else  // Otherwise, insert newNode
   {
      // Position nodePtr at the head of list.
      nodePtr = head;

      // Initialize previousNode to nullptr.
      previousNode = nullptr;

      // Skip all nodes whose letter is less than num.
      while (nodePtr != nullptr && nodePtr->letter < c)
      {  
         previousNode = nodePtr;
         nodePtr = nodePtr->next;
      }

      // If the new node is to be the 1st in the list,
      // insert it before all other nodes.
      if (previousNode == nullptr)
      {
         head = newNode;
         newNode->next = nodePtr;
      }
      else  // Otherwise insert after the previous node.
      {
         previousNode->next = newNode;
         newNode->next = nodePtr;
      }
   }
}

void CharList::deleteNode(char c)
{
   ListNode *nodePtr;       // To traverse the list
   ListNode *previousNode;  // To point to the previous node

   // If the list is empty, do nothing.
   if (!head)
      return;
   
   // Determine if the first node is the one.
   if (head->letter == c)
   {
      nodePtr = head->next;
      delete head;
      head = nodePtr;
   }
   else
   {
      // Initialize nodePtr to head of list
      nodePtr = head;

      // Skip all nodes whose letter member is 
      // not equal to num.
      while (nodePtr != nullptr && nodePtr->letter != c)
      {  
         previousNode = nodePtr;
         nodePtr = nodePtr->next;
      }

      // If nodePtr is not at the end of the list, 
      // link the previous node to the node after
      // nodePtr, then delete nodePtr.
      if (nodePtr)
      {
         previousNode->next = nodePtr->next;
         delete nodePtr;
      }
   }
}

int CharList::findStr(char c[]) {
    ListNode *nodePtr;  // To move through the list

    nodePtr = head; // start at the beginning

    int iter = 0; // iterate through the cstring
    int pos = 0; // the position of the first matching character
    while (nodePtr) // until the lisk is all gone through
    {
        if(c[iter] == nodePtr->letter) { // if the current letter matches the node letter
            iter++; // move on to the next letter
            if(c[iter] == '\0') // if it's the end of the string, the string has been found
                return pos; // return the starting position of the cstring
        }
        if(iter == 0) // if the first character has yet to be found
            pos++; // increase the current position
        nodePtr = nodePtr->next; // move on to the next node
    }
    return -1; // if it fails, return -1
}

void CharList::showReverse() {
    showReverse(head); // wrapper for recursion
}

void CharList::showReverse(ListNode *nodePtr) {
    if(nodePtr == nullptr) // if it's not the end of the list
        return;
    else {
        showReverse(nodePtr->next); // call on the next node
        cout << nodePtr->letter << endl; // and print afterwards
    }
}

int CharList::lenStr() {
    return lenStr(head); // wrapper for lenStr
}

int CharList::lenStr(ListNode *nodePtr) {
    if(nodePtr) // if it is not hte end of the list
        return 1 + lenStr(nodePtr->next); // add 1 to the return and continue calls for rest of the list
    else return 0; // otherwise, don't count it
}

void CharList::cpyStr(char c[]) {
    destroy(); // clear the list
    catStr(c); // add the string to the end (new beginning) of the list
}

void CharList::catStr(char c[]) {
    int iter = 0; 
    while(c[iter] != '\0') { // go through each character in the cstring
        appendNode(c[iter]); // and add the node to the end
        iter++;
    }
}

void CharList::destroy()
{
   ListNode *nodePtr;   // To traverse the list
   ListNode *nextNode;  // To point to the next node

   // Position nodePtr at the head of the list.
   nodePtr = head;

   // While nodePtr is not at the end of the list...
   while (nodePtr != nullptr)
   {
      // Save a pointer to the next node.
      nextNode = nodePtr->next;
      // Delete the current node.
      delete nodePtr;
      // Position nodePtr at the next node.
      nodePtr = nextNode;
   }
   head = nullptr; // reset head to avoid infinite loop after destroy is called
}

CharList::~CharList() {
    destroy(); // clear the memory when it falls out of scope
}