#include "skeleton/build_information.hpp"

#include "skeleton/version.hpp"

#include <sstream>

namespace skeleton
{

int VersionMajor()
{
    return SKELETON_VERSION_MAJOR +0;
}

int VersionMinor()
{
    return SKELETON_VERSION_MINOR +0;
}

int VersionPatch()
{
    return SKELETON_VERSION_PATCH +0;
}

std::string Version()
{
    auto ss = std::ostringstream{};
    ss << VersionMajor() << "."
       << VersionMinor() << "."
       << VersionPatch();
    return ss.str();
}

std::string BuildInformation()
{
    auto ss = std::ostringstream{};
    ss << "Skeleton Version " << Version();
    return ss.str();
}

} // namespace skeleton
