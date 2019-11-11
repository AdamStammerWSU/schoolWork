#include <iostream>
#include <iomanip>

using namespace std;

struct TwoVals {
    int a,b,c;
};

int main() {
    TwoVals s, *sptr = nullptr;
    sptr = &s;
    (*sptr).a = 1;
    return 0;
}