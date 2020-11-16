#include <iostream>
using namespace std;

class NumArray
{
    private:
        int * pNumbers;
        int iSize;
        bool bSorted;
    public:
        NumArray(int);
        NumArray(NumArray &);
        ~NumArray();
        void setItem(int loc, int value);
        int getItem(int loc) const;
        float findAvg() const;
        void sortAscend();
        float findMedian();
        void printData();
};

//Constructor
NumArray::NumArray(int arySize)
{
    iSize = arySize;
    bSorted = false;
    pNumbers = new int[iSize];  //dynamic allocation

    //zeros out array
    for(int i = 0; i < iSize; i++)
    {
        pNumbers[i] = 0;
    }
}

//Copy Constructor -- copies all the attributes of the first object to a new one
NumArray::NumArray(NumArray & objOne)
{
    iSize = objOne.iSize;
    bSorted = objOne.bSorted;

    pNumbers = new int[iSize];  //dynamic memory allocation

    for(int i = 0; i<iSize; i++)
    {
        pNumbers[i] = objOne.pNumbers[i];
    }
}

//destructor -- called when object goes out of scope
NumArray::~NumArray()
{
    delete pNumbers;
}

//takes in a location and value, checks that location is valid, and then puts that value in it
void NumArray:: setItem(int loc, int value)
{
    //validation
    while(loc <0 && loc >= iSize)
    {
        cout << "Invalid location. Please enter new value: ";
        cin >> loc;
    }

    pNumbers[loc] = value;
}

//takes in a location, checks that its valid, then return the value in it
int NumArray::getItem(int loc) const
{
    //validation
    while(loc <0 && loc >= iSize)
    {
        cout << "Invalid location. Please enter new value: ";
        cin >> loc;
    }

    return pNumbers[loc];
}

//finds the average of all the values in the array
float NumArray::findAvg() const
{
    float total = 0;

    for(int i  = 0; i < iSize; i++)
    {
        total += pNumbers[i];
    }

    return total/iSize;
}

//sorts array in ascending order -- sets bSorted to true
void NumArray::sortAscend()
{
    int tempNum;

    int a;
    int smallest;

    for(int i = 0; i<iSize-1; i++)
    {
        smallest = i;

        for(a = i +1; a < iSize; a++)
        {
            if(pNumbers[a] < pNumbers[smallest])
            {
                smallest = a;
            }
        }

        tempNum = pNumbers[i];
        pNumbers[i] = pNumbers[smallest];
        pNumbers[smallest] = tempNum;

    }

    bSorted = true;
}

//Finds the median of the array
float NumArray::findMedian()
{
    //if(!bSorted)
      //  sortAscend();
    int midPoint;
    float midValue;
    
    if(iSize % 2 == 0)
    {
        midPoint = iSize/2;
        midValue = (pNumbers[midPoint]+pNumbers[midPoint-1])/2;
    } 

    else
    {
        midPoint = iSize/2;
        midValue = pNumbers[midPoint];
    }

    return midValue;
}

//Displays information for objects and contents of array
void NumArray::printData()
{
    cout << "Array Values: ";
    for(int i = 0; i<iSize; i++)
    {
        cout << pNumbers[i] << " ";
    }

    cout << endl;

    if(bSorted)
    {
        cout << "Median Value: " << findMedian() << endl;
    }
    cout << "Average Value of Array: " << findAvg() << endl;
}

int main()
{
    int size;
    cout << "Enter a size: ";
    cin >> size;

    NumArray objOne(size);

    int value;
    for(int i=0; i<size; i++)
    {
        cout << "Enter a value for location " << i+1 << ": ";
        cin >> value;

        objOne.setItem(i, value);
    }

    objOne.findAvg();
    objOne.sortAscend();
    objOne.findMedian();

    NumArray objTwo(objOne);

    objTwo.printData();

    return 0;
}
