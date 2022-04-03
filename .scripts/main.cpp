#include <iostream>

void func(void (*f)(void (*f)))
{
}

int main()
{
	func(func(func()));
}
