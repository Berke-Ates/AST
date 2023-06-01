module {
  func.func private @external_dce_flag_1()
  func.func @main() -> i32 {
    %c2_i32 = arith.constant 2 : i32
    call @external_dce_flag_1() : () -> ()
    return %c2_i32 : i32
  }
}

