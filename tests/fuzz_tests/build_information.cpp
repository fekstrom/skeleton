#include "skeleton/build_information.h"

#include <cstddef>
#include <cstdint>

using namespace skeleton;

extern "C" int LLVMFuzzerTestOneInput(const uint8_t* bytes, size_t num_bytes)
{
    if (num_bytes == 0U) return 0;
    switch (bytes[0] % 9U) {
    case 0U:
        VersionMajor();
        break;
    case 1U:
        VersionMinor();
        break;
    case 2U:
        VersionPatch();
        break;
    case 3U:
        Version();
        break;
    case 4U:
        EigenWorldVersion();
        break;
    case 5U:
        EigenMajorVersion();
        break;
    case 6U:
        EigenMinorVersion();
        break;
    case 7U:
        EigenVersion();
        break;
    case 8U:
        BuildInformation();
        break;
    }
    return 0;
}
