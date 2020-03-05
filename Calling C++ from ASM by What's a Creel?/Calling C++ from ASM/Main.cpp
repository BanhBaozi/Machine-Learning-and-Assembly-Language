#include <iostream>
#include <conio.h>

using namespace std;

extern "C" void CallACPPProcedure();

extern "C" void MyProc(int a, int b, int c, int d, int e, int f)
  {
   cout << "Hello, I got all your params! " << e << endl; 
  }
  
int main() 
  {
 CallACPPProcedure();
 _getch();
 return 0;
  }
