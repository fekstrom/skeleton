#ifndef SKELETON_BUILD_INFORMATION_HPP_
#define SKELETON_BUILD_INFORMATION_HPP_

#include <string>

namespace skeleton
{

/// @return The `major` component of the Skeleton version.
auto VersionMajor() -> int;

/// @return The `minor` component of the Skeleton version.
auto VersionMinor() -> int;

/// @return The `patch` component of the Skeleton version.
auto VersionPatch() -> int;

/// @return The Skeleton version, as a string.
auto Version() -> std::string;

/// @return A summary of build information for Skeleton.
auto BuildInformation() -> std::string;

} // namespace skeleton

#endif // Include guard
