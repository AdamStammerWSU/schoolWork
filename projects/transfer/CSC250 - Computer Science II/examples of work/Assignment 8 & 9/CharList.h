// Specification file for the NumberList class
#ifndef CHARLIST_H
#define CHARLIST_H

class CharList
{
private:
   // Declare a structure for the list
    struct ListNode
    {
        char letter;           // The value in this node
        struct ListNode *next;  // To point to the next node
    }; 

    ListNode *head;          // List head pointer

    int lenStr(ListNode *);
    void showReverse(ListNode *);
    void destroy();

public:
   // Constructor
    CharList()
      { head = nullptr; }
      
   // Destructor
    ~CharList();
      
   // Linked list operations
    void appendNode(char);
    void insertNode(char);
    void deleteNode(char);
    void displayList() const;
    int findStr(char []);
    void catStr(char []);
    void cpyStr(char []);
    int lenStr();
    void showReverse();
};
#endif