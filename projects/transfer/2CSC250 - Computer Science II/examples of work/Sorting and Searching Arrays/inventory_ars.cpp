// Calculate the area of a rectangle
#include <iostream>
#include <iomanip>

using namespace std;

int main() {
    double width, height;
    cout << "What is the width and height?: ";
    cin >> width >> height;                // read in the height
    if(width == NULL || height == NULL) {
        cout << "The given input cannot be processed.";
        return 0;
    }
    double area = width * height;          // calculate the area
    cout << "The area of a rectangle of the given dimensions is " << fixed << setprecision(4) << area << " units squared.\n"; // print out the area

    return 0;
}
