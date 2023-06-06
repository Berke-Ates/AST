module {
  func.func @main() -> i32 {
    %alloca = memref.alloca() : memref<100000x100000x100000xi8>
    %alloc = memref.alloc() : memref<2x100000x1xi16>
    %c0 = arith.constant 0 : i32
    return %c0  : i32
  }
}
