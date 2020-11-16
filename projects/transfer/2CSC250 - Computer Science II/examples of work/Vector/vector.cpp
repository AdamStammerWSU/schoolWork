#include <iostream>
#include <iomanip>
#include <vector>

using namespace std;

int main() {
    vector<int> scores = {1, 2, 3};
    vector<int> scores2 = {1, 2, 3, 4, 5};
    cout << "Scores: " << endl;
    for(int i : scores) {
        cout << i << endl;
    }
    cout << "Size: " << endl;
    cout << scores.size() << endl;
    cout << "Scores2: " << endl;
    for(int i : scores2) {
        cout << i << endl;
    }
    cout << "Size2: " << scores2.size() << endl;

    scores.swap(scores2);


    for(int i : scores) {
        cout << i << endl;
    }    cout << "Scores: " << endl;
    for(int i : scores) {
        cout << i << endl;
    }
    cout << "Size: " << endl;
    cout << scores.size() << endl;
    cout << "Scores2: " << endl;
    for(int i : scores2) {
        cout << i << endl;
    }
    cout << "Size2: " << scores2.size() << endl;

    return 0;
}