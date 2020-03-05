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


//Read single Keypress - do not wait for Enter key
extern "C" void ReadKey(char* pc)		//byte
{
	*pc = _getch();
}

//Read an ASCII character - wait for Enter key
//Note: also replaces a second byte with null, so 2 bytes required
extern "C" void ReadChar(char* pc)		//byte (plus sentinel)
{
	cin >> pc;
}

//Read a decimal number - wait for Enter key
extern "C" void ReadByte(char* pc)		//byte
{
	//scanf_s("%hhd", pc);
	short n = 0;
	cin >> n;
	*pc = (char)n;
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





extern "C" void DisplayChar(char* pc)	//byte as character
{
	//cout << *pc;
	printf("%c ", *pc);
}

extern "C" void DisplayByte(char* pc)	//byte as number
{
	printf("%d ", *pc);
}

extern "C" void DisplayShort(short* ps)	//word
{
	printf("%d ", *ps);
	//cout << *ps;
}

extern "C" void DisplayInt(int* pi)		//dword
{
	printf("%d ", *pi);
	//cout << *pi;
}

extern "C" void DisplayLLong(long long* pl) //qword
{
	printf("%lld ", *pl);
	//cout << *pl;
}


extern "C" void DisplayUByte(unsigned char* pc)	//byte as number
{
	printf("%hhu ", *pc);
}

extern "C" void DisplayUShort(unsigned short* ps)	//word
{
	printf("%hu ", *ps);
	//cout << *ps;
}

extern "C" void DisplayUInt(unsigned int* pi)		//dword
{
	printf("%lu ", *pi);
	//cout << *pi;
}

extern "C" void DisplayULLong(unsigned long long* pl) //qword
{
	printf("%llu ", *pl);
	//cout << *pl;
}


extern "C" void DisplayString(char* pc)	//byte array
{
	while (*pc > 0)
		putchar(*pc++);
}

extern "C" void DisplayFloat(float* pf)	//real4
{
	printf("%.7g ", *pf);
	//cout << *pf;
}

extern "C" void DisplayDouble(double* pd) //real8
{
	printf("%.16g ", *pd);
	//cout << *pd;
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
		printf("%02hhx ", *pc);
	}
}

//pc=offset of memory, count=#bytes to display
extern "C" void DisplayMemoryBinary(unsigned char* pc, int count)
{
	for (int i = 0; i < count; i++, pc++)
		cout << bitset<8>(*pc) << " ";
}
