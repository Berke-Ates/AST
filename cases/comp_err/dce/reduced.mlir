module {
  func.func private @external_dce_flag_1()
  func.func @main() -> i32 {
    %alloc = memref.alloc() : memref<i64>
    memref.copy %alloc, %alloc : memref<i64> to memref<i64>
    call @external_dce_flag_1() : () -> ()
    %0 = memref.load %alloc[] : memref<i64>
    %c2_i32 = arith.constant 2 : i32
    return %c2_i32 : i32
  }
}
