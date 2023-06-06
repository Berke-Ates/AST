module {
  func.func private @external_dce_flag_1()
  func.func @main() -> i32 {
    call @external_dce_flag_1() : () -> ()
    %alloc = memref.alloc() {generate_initialized = true} : memref<1x100000x100000xf64>
    %c0 = arith.constant 0 : index
    %c23252 = arith.constant 23252 : index
    %c39434 = arith.constant 39434 : index
    %0 = memref.load %alloc[%c0, %c23252, %c39434] : memref<1x100000x100000xf64>
    %c0_0 = arith.constant 0 : index
    %c10348 = arith.constant 10348 : index
    %c94387 = arith.constant 94387 : index
    memref.store %0, %alloc[%c0_0, %c10348, %c94387] : memref<1x100000x100000xf64>
    %1 = arith.subi %c39434, %c0_0 : index
    %2 = arith.index_cast %c23252 : index to i32
    return %2 : i32
  }
}
