module {
  func.func private @external_dce_flag_2()
  func.func private @external_dce_flag_1()
  func.func @main() -> i32 {
    %c-2_i8 = arith.constant -2 : i8
    %alloca = memref.alloca() {generate_initialized = false} : memref<2xindex>
    %0 = arith.extsi %c-2_i8 : i8 to i64
    %1 = arith.extsi %c-2_i8 : i8 to i64
    %2 = arith.remui %0, %1 : i64
    %3 = arith.cmpi ugt, %c-2_i8, %c-2_i8 : i8
    %4 = arith.addi %0, %1 : i64
    call @external_dce_flag_1() : () -> ()
    %5 = arith.remui %2, %2 : i64
    %6 = arith.extsi %c-2_i8 : i8 to i64
    %7 = arith.muli %0, %0 : i64
    %8 = arith.subi %c-2_i8, %c-2_i8 : i8
    %9 = arith.extsi %3 : i1 to i8
    %10 = arith.cmpi ule, %6, %7 : i64
    %11 = arith.extsi %10 : i1 to i32
    %12 = arith.addi %11, %11 : i32
    %13 = arith.extsi %11 : i32 to i64
    call @external_dce_flag_2() : () -> ()
    %14 = arith.select %10, %11, %11 : i32
    return %12 : i32
  }
}
