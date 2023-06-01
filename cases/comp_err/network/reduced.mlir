module {
  func.func @main() -> i32 {
    %alloca = memref.alloca() : memref<index>
    memref.copy %alloca, %alloca : memref<index> to memref<index>
    %c0_i32 = arith.constant 0 : i32
    return %c0_i32 : i32
  }
}
