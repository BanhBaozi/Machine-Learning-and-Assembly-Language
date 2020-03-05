#include <iostream>
#include <conio.h>

using namespace std;

extern "C" short PassingParameters(short a, short b, short c, short d);

int main()
{
  cout << "The function returned : " << PassingParameters(2,4,6,5);
  _getch();
  return 0;
}
