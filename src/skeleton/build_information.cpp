#include "skeleton/build_information.hpp"

#include "skeleton/version.hpp"

#include <sstream>

namespace skeleton
{

auto VersionMajor() -> int
{
    return SKELETON_VERSION_MAJOR +0;
}

auto VersionMinor() -> int
{
    return SKELETON_VERSION_MINOR +0;
}

auto VersionPatch() -> int
{
    return SKELETON_VERSION_PATCH +0;
}

auto Version() -> std::string
{
    auto ss = std::ostringstream{};
    ss << VersionMajor() << "."
       << VersionMinor() << "."
       << VersionPatch();
    return ss.str();
}

auto BuildInformation() -> std::string
{
    auto ss = std::ostringstream{};
    ss << "Skeleton Version " << Version();
    return ss.str();
}

} // namespace skeleton
