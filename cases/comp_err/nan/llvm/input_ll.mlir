module attributes {llvm.data_layout = ""} {
  llvm.func @external_dce_flag_2() attributes {sym_visibility = "private"}
  llvm.func @external_dce_flag_1() attributes {sym_visibility = "private"}
  llvm.func @main() -> i32 {
    llvm.call @external_dce_flag_1() : () -> ()
    %0 = llvm.mlir.constant(1 : i64) : i64
    %1 = llvm.mlir.constant(-1.41006613 : f32) : f32
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.constant(2 : index) : i64
    %4 = llvm.mlir.constant(1 : index) : i64
    %5 = llvm.mlir.constant(2 : index) : i64
    %6 = llvm.mlir.null : !llvm.ptr<i64>
    %7 = llvm.getelementptr %6[2] : (!llvm.ptr<i64>) -> !llvm.ptr<i64>
    %8 = llvm.ptrtoint %7 : !llvm.ptr<i64> to i64
    %9 = llvm.alloca %8 x i64 : (i64) -> !llvm.ptr<i64>
    %10 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %12 = llvm.insertvalue %9, %11[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.mlir.constant(0 : index) : i64
    %14 = llvm.insertvalue %13, %12[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %2, %14[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %3, %15[3, 1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.insertvalue %3, %16[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %18 = llvm.insertvalue %4, %17[4, 1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    llvm.call @external_dce_flag_2() : () -> ()
    %19 = llvm.mlir.constant(0.160039037 : f32) : f32
    %20 = llvm.mlir.constant(0 : index) : i64
    %21 = llvm.mlir.constant(0 : index) : i64
    %22 = llvm.mlir.constant(2 : index) : i64
    %23 = llvm.mul %20, %22  : i64
    %24 = llvm.add %23, %21  : i64
    %25 = llvm.getelementptr %9[%24] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    llvm.store %0, %25 : !llvm.ptr<i64>
    %26 = llvm.mlir.constant(false) : i1
    %27 = llvm.mlir.constant(0xFFC00000 : f32) : f32
    %28 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %28 : i32
  }
}

