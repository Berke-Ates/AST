/* DaCe AUTO-GENERATED FILE. DO NOT MODIFY */
#include <dace/dace.h>
#include "../../include/hash.h"

struct sdfg_0_t {
    dace::perf::Report report;
};


#include <chrono>
#include <chrono>
extern "C" void external_dce_flag_1();

void __program_sdfg_0_internal(sdfg_0_t *__state, int * __restrict__ _arg0)
{
    auto __dace_tbegin_0 = std::chrono::high_resolution_clock::now();

    {

        {

            ///////////////////
            external_dce_flag_1();
            ///////////////////

        }
        {
            int __out;

            ///////////////////
            // Tasklet code (symassign)
            __out = 0;
            ///////////////////

            _arg0[0] = __out;
        }

    }
    auto __dace_tend_0 = std::chrono::high_resolution_clock::now();
    unsigned long int __dace_ts_start_0 = std::chrono::duration_cast<std::chrono::microseconds>(__dace_tbegin_0.time_since_epoch()).count();
    unsigned long int __dace_ts_end_0 = std::chrono::duration_cast<std::chrono::microseconds>(__dace_tend_0.time_since_epoch()).count();
    __state->report.add_completion("SDFG sdfg_0", "Timer", __dace_ts_start_0, __dace_ts_end_0, 0, -1, -1);
}

DACE_EXPORTED void __program_sdfg_0(sdfg_0_t *__state, int * __restrict__ _arg0)
{
    __program_sdfg_0_internal(__state, _arg0);
}

DACE_EXPORTED sdfg_0_t *__dace_init_sdfg_0()
{
    int __result = 0;
    sdfg_0_t *__state = new sdfg_0_t;



    if (__result) {
        delete __state;
        return nullptr;
    }
    return __state;
}

DACE_EXPORTED void __dace_exit_sdfg_0(sdfg_0_t *__state)
{
    __state->report.save("./out/smith_9/dace/.dacecache/sdfg_0/perf", __HASH_sdfg_0);
    delete __state;
}

