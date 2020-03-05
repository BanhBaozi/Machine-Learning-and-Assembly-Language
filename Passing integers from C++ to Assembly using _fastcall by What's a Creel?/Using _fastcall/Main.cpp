#include <iostream>
#include <conio.h>

using namespace std;

extern "C" int PassingParameters(int a. int b);

int main()
{
  cout << "The function returned : " << PassingParameters(189,23);
  _getch();
  return 0;
}
