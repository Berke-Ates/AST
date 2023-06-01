module {
  func.func @main() -> i32 {
    %alloc = memref.alloc() : memref<0xi32>
    %c0 = arith.constant 0 : index
    %0 = memref.load %alloc[%c0] : memref<0xi32>
    %c0_i32 = arith.constant 0 : i32
    %1 = arith.maxsi %0, %c0_i32 : i32
    return %c0_i32 : i32
  }
}
