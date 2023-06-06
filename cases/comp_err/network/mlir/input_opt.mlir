module {
  func.func private @external_dce_flag_2()
  func.func private @external_dce_flag_1()
  func.func @main() -> i32 {
    %c0_i32 = arith.constant 0 : i32
    call @external_dce_flag_1() : () -> ()
    call @external_dce_flag_2() : () -> ()
    return %c0_i32 : i32
  }
}

