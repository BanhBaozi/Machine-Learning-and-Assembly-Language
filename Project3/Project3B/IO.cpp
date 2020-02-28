/*
Listing3-6B
I/O methods in C++

Your program entry point must be "main"

Be sure to preserve the base pointer before calling
 and restore it (and possibly other non-volatile registers) afterwards

When using this to create an object module:
Release Mode
C++ Compile switch /GL removed (set Whole Program Optimization to NO)

Not necessary to submit this file with your project.
*/

#include <iostream>
#include <iomanip>
#include <conio.h>
#include <bitset>

using namespace std;

extern "C" void ReadByte(char* pc)		//byte (no Enter)
{
	*pc = _getch();
}

extern "C" void ReadChar(char* pc)		//byte (plus sentinel)
{
	cin >> pc;
}

extern "C" void ReadShort(short* ps)	//word
{
	cin >> *ps;
}

extern "C" void ReadInt(int* pi)		//dword
{
	cin >> *pi;
}

extern "C" void ReadLLong(long long* pl)//qword
{
	cin >> *pl;
}

//reads a string, returns sizeof string (including \0)
extern "C" int ReadString(char pc[])	//byte array
{
	cin.getline(pc, 255, '\n');
	return (int)cin.gcount();
}

extern "C" void ReadFloat(float* pf)	//real4
{
	cin >> *pf;
}

extern "C" void ReadDouble(double* pd)	//real8
{
	cin >> *pd;
}

extern "C" void DisplayChar(char* pc)	//byte
{
	cout << *pc;
}

extern "C" void DisplayShort(short* ps)	//word
{
	cout << *ps;
}

extern "C" void DisplayInt(int* pi)		//dword
{
	cout << *pi;
}

extern "C" void DisplayLLong(long long* pl) //qword
{
	cout << *pl;
}

extern "C" void DisplayString(char* pc)	//byte array
{
	while (*pc > 0)
		putchar(*pc++);
}

extern "C" void DisplayFloat(float* pf)	//real4
{
	cout << *pf;
}

extern "C" void DisplayDouble(double* pd) //real8
{
	cout << *pd;
}

extern "C" void DisplayNewline()
{
	cout << std::endl;
}

//This function should be called between calls to 
//Read(any numeric type) and Read(character type)
extern "C" void ClearBuff() //clear (keyboard) input buffer
{
	cin.ignore();
}

//pc=offset of memory, count=#bytes to display
extern "C" void DisplayMemory(unsigned char *pc, int count)
{
	if (count > 500 || count < 1) return;
	for (int i = 0; i < count; i++, pc++)
	{
		cout << hex << setfill('0') << setw(2)
			<< static_cast<unsigned short>(*pc) << " ";
	}
}

//pc=offset of memory, count=#bytes to display
extern "C" void DisplayMemoryBinary(unsigned char* pc, int count)
{
	for (int i = 0; i < count; i++, pc++)
		cout << bitset<8>(*pc) << " ";
}
