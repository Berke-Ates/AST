module {
  func.func private @external_dce_flag_1()
  func.func @main() -> i32 {
    %alloca = memref.alloca() {generate_deallocated = true, generate_initialized = false} : memref<100000xi64>
    call @external_dce_flag_1() : () -> ()
    memref.dealloc %alloca : memref<100000xi64>
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
}
