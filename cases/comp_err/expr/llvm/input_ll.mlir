module attributes {llvm.data_layout = ""} {
  llvm.func @external_dce_flag_2() attributes {sym_visibility = "private"}
  llvm.func @external_dce_flag_1() attributes {sym_visibility = "private"}
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(-2 : i8) : i8
    %1 = llvm.mlir.constant(2 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.null : !llvm.ptr<i64>
    %4 = llvm.getelementptr %3[2] : (!llvm.ptr<i64>) -> !llvm.ptr<i64>
    %5 = llvm.ptrtoint %4 : !llvm.ptr<i64> to i64
    %6 = llvm.alloca %5 x i64 : (i64) -> !llvm.ptr<i64>
    %7 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)>
    %8 = llvm.insertvalue %6, %7[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)> 
    %9 = llvm.insertvalue %6, %8[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)> 
    %10 = llvm.mlir.constant(0 : index) : i64
    %11 = llvm.insertvalue %10, %9[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)> 
    %12 = llvm.insertvalue %1, %11[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)> 
    %13 = llvm.insertvalue %2, %12[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<1 x i64>, array<1 x i64>)> 
    %14 = llvm.mlir.constant(-2 : i64) : i64
    %15 = llvm.mlir.constant(-2 : i64) : i64
    %16 = llvm.urem %14, %15  : i64
    %17 = llvm.mlir.constant(false) : i1
    %18 = llvm.add %14, %15  : i64
    llvm.call @external_dce_flag_1() : () -> ()
    %19 = llvm.urem %16, %16  : i64
    %20 = llvm.mlir.constant(-2 : i64) : i64
    %21 = llvm.mul %14, %14  : i64
    %22 = llvm.mlir.constant(0 : i8) : i8
    %23 = llvm.sext %17 : i1 to i8
    %24 = llvm.icmp "ule" %20, %21 : i64
    %25 = llvm.sext %24 : i1 to i32
    %26 = llvm.add %25, %25  : i32
    %27 = llvm.sext %24 : i1 to i64
    llvm.call @external_dce_flag_2() : () -> ()
    llvm.return %26 : i32
  }
}

