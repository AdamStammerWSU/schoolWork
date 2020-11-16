#include <iostream>
#include <fstream>

using namespace std;


const int MAX_DATA_SIZE = 0;

int main() {
    char h[2][9] = {
        {'H', 'o', 'w', 'd', 'y', ',', ' '},
        {'M', 'i', 't', 'c', 'h', 'e', 'l', 'l', '!',}
    };

    for (int x = 0; x < 2; x++) {
        for (char c : h[x]) {
            cout << c;
        }
    }
    cout << "\n";

    return 0;
}
