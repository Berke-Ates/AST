module attributes {llvm.data_layout = ""} {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @external_dce_flag_1() attributes {sym_visibility = "private"}
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(100000 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.null : !llvm.ptr<i64>
    %3 = llvm.getelementptr %2[100000] : (!llvm.ptr<i64>) -> !llvm.ptr<i64>
    %4 = llvm.ptrtoint %3 : !llvm.ptr<i64> to i64
    %5 = llvm.alloca %4 x i64 : (i64) -> !llvm.ptr<i64>
    %6 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %7 = llvm.insertvalue %5, %6[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)> 
    %8 = llvm.insertvalue %5, %7[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.mlir.constant(0 : index) : i64
    %10 = llvm.insertvalue %9, %8[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)> 
    %11 = llvm.insertvalue %0, %10[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %1, %11[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)> 
    llvm.call @external_dce_flag_1() : () -> ()
    %13 = llvm.bitcast %5 : !llvm.ptr<i64> to !llvm.ptr<i8>
    llvm.call @free(%13) : (!llvm.ptr<i8>) -> ()
    %14 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %14 : i32
  }
}

