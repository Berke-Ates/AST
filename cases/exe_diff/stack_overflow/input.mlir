module {
  func.func private @external_dce_flag_5()
  func.func private @external_dce_flag_4()
  func.func private @external_dce_flag_3()
  func.func private @external_dce_flag_2()
  func.func private @external_dce_flag_1()
  func.func @main() -> i32 {
    call @external_dce_flag_1() : () -> ()
    %alloca = memref.alloca() {generate_initialized = false} : memref<100000x100000x100000xi8>
    call @external_dce_flag_2() : () -> ()
    %c0_i16 = arith.constant 0 : i16
    call @external_dce_flag_3() : () -> ()
    %0 = arith.index_cast %c0_i16 : i16 to index
    %c1_i16 = arith.constant 1 : i16
    %1 = arith.maxsi %c0_i16, %c1_i16 : i16
    %2 = arith.remsi %c0_i16, %1 : i16
    %3 = arith.addi %1, %c1_i16 : i16
    call @external_dce_flag_4() : () -> ()
    %4 = arith.extui %1 : i16 to i32
    %5 = arith.cmpi ult, %2, %3 : i16
    call @external_dce_flag_5() : () -> ()
    %alloc = memref.alloc() {generate_initialized = false} : memref<2x100000x1xi16>
    %6 = arith.subi %4, %4 : i32
    return %6 : i32
  }
}
