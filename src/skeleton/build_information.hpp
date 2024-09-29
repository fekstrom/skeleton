#ifndef SKELETON_BUILD_INFORMATION_H_
#define SKELETON_BUILD_INFORMATION_H_

#include <string>

namespace skeleton
{

/// @return The `major` component of the Skeleton version.
int VersionMajor();

/// @return The `minor` component of the Skeleton version.
int VersionMinor();

/// @return The `patch` component of the Skeleton version.
int VersionPatch();

/// @return The Skeleton version, as a string.
std::string Version();

/// @return A summary of build information for Skeleton.
std::string BuildInformation();

} // namespace skeleton

#endif // Include guard
