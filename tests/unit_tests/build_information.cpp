#include "skeleton/build_information.h"

#include <catch2/catch_test_macros.hpp>

#include <iostream>

using namespace skeleton;

TEST_CASE("Version")
{
    REQUIRE(VersionMajor() >= 0);
    REQUIRE(VersionMinor() >= 0);
    REQUIRE(VersionPatch() >= 0);
    REQUIRE(!Version().empty());
}

TEST_CASE("EigenVersion")
{
    REQUIRE(EigenWorldVersion() >= 0);
    REQUIRE(EigenMajorVersion() >= 0);
    REQUIRE(EigenMinorVersion() >= 0);
    REQUIRE(!EigenVersion().empty());
}

TEST_CASE("BuildInformation")
{
    REQUIRE(!BuildInformation().empty());
    std::cout << BuildInformation() << "\n";
}
