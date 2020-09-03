#include <iostream>

using namespace std;

int main() {
    float a = 0.1;
    float sum = 0;
    int t = 0;
    cout << "N: ";
    cin >> t;
    for (int i = 0; i < t; i++) {
        sum += a;
    }
    cout << "a: " << sum << "\n";
    cout << "tru: " << t*a << "\n";
}