#include "skeleton/build_information.hpp"

#include <iostream>

auto main() -> int
{
    std::cout << skeleton::BuildInformation() << "\n";
    return 0;
}
