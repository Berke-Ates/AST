module {
  func.func private @external_dce_flag_2()
  func.func private @external_dce_flag_1()
  func.func @main() -> i32 {
    call @external_dce_flag_1() : () -> ()
    %alloca = memref.alloca() {generate_deallocated = true, generate_initialized = false} : memref<index>
    memref.dealloc %alloca : memref<index>
    %alloca_0 = memref.alloca() {generate_deallocated = true, generate_initialized = false} : memref<100000x1x2xf32>
    memref.copy %alloca, %alloca : memref<index> to memref<index>
    %alloca_1 = memref.alloca() {generate_deallocated = true, generate_initialized = false} : memref<2x2xindex>
    memref.dealloc %alloca_0 : memref<100000x1x2xf32>
    call @external_dce_flag_2() : () -> ()
    memref.copy %alloca_1, %alloca_1 : memref<2x2xindex> to memref<2x2xindex>
    memref.copy %alloca, %alloca : memref<index> to memref<index>
    %c1_i64 = arith.constant 1 : i64
    memref.dealloc %alloca_1 : memref<2x2xindex>
    %c0_i16 = arith.constant 0 : i16
    %0 = arith.extui %c0_i16 : i16 to i64
    %1 = arith.extui %c0_i16 : i16 to i32
    return %1 : i32
  }
}
