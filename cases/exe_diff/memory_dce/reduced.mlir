module {
  func.func @main() -> i32 {
    %c0 = arith.constant 0 : index
    %alloc = memref.alloc() : memref<100000x100000xi64>
    %0 = memref.load %alloc[%c0,%c0] : memref<100000x100000xi64>
    memref.store %0, %alloc[%c0,%c0] : memref<100000x100000xi64>
    memref.dealloc %alloc : memref<100000x100000xi64>
    %c2_i32 = arith.constant 2 : i32
    return %c2_i32 : i32
  }
}
