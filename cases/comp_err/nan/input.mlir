module {
  func.func private @external_dce_flag_2()
  func.func private @external_dce_flag_1()
  func.func @main() -> i32 {
    call @external_dce_flag_1() : () -> ()
    %c1_i64 = arith.constant 1 : i64
    %cst = arith.constant -1.41006613 : f32
    %alloca = memref.alloca() {generate_initialized = true} : memref<1x2xi64>
    call @external_dce_flag_2() : () -> ()
    %0 = math.cos %cst : f32
    %c0 = arith.constant 0 : index
    %c0_0 = arith.constant 0 : index
    memref.store %c1_i64, %alloca[%c0, %c0_0] : memref<1x2xi64>
    %1 = arith.cmpf olt, %cst, %cst : f32
    %2 = math.powf %cst, %cst : f32
    %3 = arith.index_cast %c0 : index to i32
    return %3 : i32
  }
}
