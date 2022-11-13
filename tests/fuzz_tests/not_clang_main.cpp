#include <iostream>

int main(int, const char* argv[])
{
    std::cout << argv[0] << ": Fuzzing is only available when compiling with Clang. Exit.\n";
    return 0;
}
