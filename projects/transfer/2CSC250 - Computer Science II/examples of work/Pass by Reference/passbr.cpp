#include <iostream>
#include <iomanip>

using namespace std;
/*  C way
void getData(int * num1, int * num2);

int main() {
    int x, y;

    getData(&x, &y);

    cout << "X: " << x << " Y: " << y;

    return 0;
}

void getData(int * num1, int * num2) {
    cout << "Enter 2 integers: ";
    cin >> *num1 >> *num2;
}
*/


//C++ Way
void getData(int & num1, int & num2);

int main() {
    int x, y;

    getData(x, y);

    cout << "X: " << x << " Y: " << y;

    return 0;
}

void getData(int & num1, int & num2) {
    cout << "Enter 2 integers: ";
    cin >> num1 >> num2;
}
