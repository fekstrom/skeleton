#include "skeleton/build_information.hpp"

#include <benchmark/benchmark.h>

#include <string>

using namespace skeleton;

static void BmBuildInformation(benchmark::State& state)
{
    for (auto _ : state)
    {
        const auto info = BuildInformation();
        benchmark::DoNotOptimize(info);
    }
}
BENCHMARK(BmBuildInformation);
