module {
  func.func @main() -> i32 {
    %c0_i8 = arith.constant 0 : i8
    %0 = arith.extsi %c0_i8 : i8 to i64
    %1 = arith.muli %0, %0 : i64
    %2 = arith.cmpi ule, %0, %1 : i64
    %3 = arith.extsi %2 : i1 to i32
    %4 = arith.addi %3, %3 : i32
    return %4 : i32
  }
}
