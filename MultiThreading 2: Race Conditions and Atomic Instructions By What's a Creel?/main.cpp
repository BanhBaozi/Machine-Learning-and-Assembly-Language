#include <Windows.h>
#include <iostream>

using namespace std

extern "C" void CreateThreadInAsm(int* i);

int main()
{
int i = 0;

CreateThreadInAsm(&i);

while(i==0) {}

cout<< "The value of i is " << i << endl;
return 0;

}
