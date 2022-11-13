#include "skeleton/build_information.h"

#include "skeleton/version.h"

#include <Eigen/Core>

#include <sstream>

namespace skeleton {

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

int EigenWorldVersion()
{
    return EIGEN_WORLD_VERSION +0;
}

int EigenMajorVersion()
{
    return EIGEN_MAJOR_VERSION +0;
}

int EigenMinorVersion()
{
    return EIGEN_MINOR_VERSION +0;
}

std::string EigenVersion()
{
    auto ss = std::ostringstream{};
    ss << EigenWorldVersion() << "."
       << EigenMajorVersion() << "."
       << EigenMinorVersion();
    return ss.str();
}

std::string BuildInformation()
{
    auto ss = std::ostringstream{};
    ss << "Skeleton Version " << Version() << "\n"
       << "Built with Eigen " << EigenVersion();
    return ss.str();
}

} // namespace skeleton
