#include <iostream>

using namespace std;

int main() {
    int iterCap = 19;
    short float x = (1.0/iterCap);
    short float sum = 0;
    for(int i = 0; i < iterCap; i++) {
        sum += x;
        cout << "Sum " << i << ": " << sum << endl;
    }
    cout << "Grade is " << (sum * 100) << "%";
    return 0;
}