#include <iostream>
#include <iomanip>
#include <fstream>

using namespace std;

int main() {
    ifstream infile;
    ofstream outfile;

    infile.open("infile.txt");
    if(!infile) {
        cout << "File failed to open.";
        return 0;
    }
    outfile.open("test.txt");
    if(!outfile) {
        cout << "Can't output to file. Likely missing permissions.";
        return 0;
    }

    cout << "Writing data to file...";
    outfile << "Test line 1\n" << "testline2\n" << "\n" << "testline4\n";
    cout << "Write succeeded!";

    infile.close();
    outfile.close();
    return 0;
}
