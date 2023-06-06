module {
  func.func private @external_dce_flag_1()
  func.func @main() -> i32 {
    %c23252_i32 = arith.constant 23252 : i32
    %c94387 = arith.constant 94387 : index
    %c10348 = arith.constant 10348 : index
    %c39434 = arith.constant 39434 : index
    %c23252 = arith.constant 23252 : index
    %c0 = arith.constant 0 : index
    call @external_dce_flag_1() : () -> ()
    %alloc = memref.alloc() {generate_initialized = true} : memref<1x100000x100000xf64>
    %0 = memref.load %alloc[%c0, %c23252, %c39434] : memref<1x100000x100000xf64>
    memref.store %0, %alloc[%c0, %c10348, %c94387] : memref<1x100000x100000xf64>
    return %c23252_i32 : i32
  }
}

