#include <iostream>
#include <stdlib.h>

using namespace std;

class Circle {
    public:
        float radius;
        Circle();
        Circle(int);
        float getArea() {return radius * radius * 3.1459;}
};

int main() {
    Circle circ[5] = {{5}};
    cout << circ[4].getArea();
}

Circle::Circle(int r) {
    radius = r;
}

Circle::Circle() {
    radius = 10;
}