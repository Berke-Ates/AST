module {
  func.func private @external_dce_flag_1()
  func.func @main() -> i32 {
    %alloc = memref.alloc() {generate_initialized = false} : memref<0x1xi64>
    memref.copy %alloc, %alloc : memref<0x1xi64> to memref<0x1xi64>
    call @external_dce_flag_1() : () -> ()
    %c0 = arith.constant 0 : index
    %c0_0 = arith.constant 0 : index
    %0 = memref.load %alloc[%c0, %c0_0] : memref<0x1xi64>
    %c1_i64 = arith.constant 1 : i64
    %1 = arith.maxsi %0, %c1_i64 : i64
    %2 = arith.divsi %0, %1 : i64
    %cst = arith.constant -5.844730e-01 : f16
    %c2_i32 = arith.constant 2 : i32
    return %c2_i32 : i32
  }
}
