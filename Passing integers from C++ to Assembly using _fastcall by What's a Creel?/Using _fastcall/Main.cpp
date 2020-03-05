#include <iostream>
#include <conio.h>

using namespace std;

extern "C" int PassingParameters(int a);

int main()
{
  cout << "The function returned : " << PassingParameters(67);
  _getch();
  return 0;
}
