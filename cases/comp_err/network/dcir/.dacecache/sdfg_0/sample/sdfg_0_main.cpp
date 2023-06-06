#include <cstdlib>
#include "../include/sdfg_0.h"

int main(int argc, char **argv) {
    sdfg_0Handle_t handle;
    int * __restrict__ _arg0 = (int*) calloc(1, sizeof(int));


    handle = __dace_init_sdfg_0();
    __program_sdfg_0(handle, _arg0);
    __dace_exit_sdfg_0(handle);



int val = *_arg0;
free(_arg0);
return val;
}
