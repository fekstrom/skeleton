#ifndef SKELETON_BUILD_INFORMATION_H_
#define SKELETON_BUILD_INFORMATION_H_

#include <string>

namespace skeleton {

/// @return The `major` component of the Skeleton version.
int VersionMajor();

/// @return The `minor` component of the Skeleton version.
int VersionMinor();

/// @return The `patch` component of the Skeleton version.
int VersionPatch();

/// @return The Skeleton version, as a string.
std::string Version();

/// @return The `world` component of the Eigen version that Skeleton was built with.
int EigenWorldVersion();

/// @return The `major` component of the Eigen version that Skeleton was built with.
int EigenMajorVersion();

/// @return The `minor` component of the Eigen version that Skeleton was built with.
int EigenMinorVersion();

/// @return The Eigen version that Skeleton was built with, as a string.
std::string EigenVersion();

/// @return A summary of build information for Skeleton.
std::string BuildInformation();

} // namespace skeleton

#endif // Include guard
