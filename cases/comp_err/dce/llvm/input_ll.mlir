module attributes {llvm.data_layout = ""} {
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @external_dce_flag_1() attributes {sym_visibility = "private"}
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(0 : index) : i64
    %1 = llvm.mlir.constant(1 : index) : i64
    %2 = llvm.mlir.constant(1 : index) : i64
    %3 = llvm.mlir.null : !llvm.ptr<i64>
    %4 = llvm.getelementptr %3[1] : (!llvm.ptr<i64>) -> !llvm.ptr<i64>
    %5 = llvm.ptrtoint %4 : !llvm.ptr<i64> to i64
    %6 = llvm.call @malloc(%5) : (i64) -> !llvm.ptr<i8>
    %7 = llvm.bitcast %6 : !llvm.ptr<i8> to !llvm.ptr<i64>
    %8 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)>
    %9 = llvm.insertvalue %7, %8[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %10 = llvm.insertvalue %7, %9[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %11 = llvm.mlir.constant(0 : index) : i64
    %12 = llvm.insertvalue %11, %10[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %13 = llvm.insertvalue %0, %12[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %14 = llvm.insertvalue %1, %13[3, 1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %15 = llvm.insertvalue %1, %14[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %16 = llvm.insertvalue %2, %15[4, 1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %17 = llvm.mlir.constant(1 : index) : i64
    %18 = llvm.mul %17, %0  : i64
    %19 = llvm.mul %18, %1  : i64
    %20 = llvm.mlir.null : !llvm.ptr<i64>
    %21 = llvm.getelementptr %20[1] : (!llvm.ptr<i64>) -> !llvm.ptr<i64>
    %22 = llvm.ptrtoint %21 : !llvm.ptr<i64> to i64
    %23 = llvm.mul %19, %22  : i64
    %24 = llvm.getelementptr %7[%11] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %25 = llvm.getelementptr %7[%11] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %26 = llvm.mlir.constant(false) : i1
    "llvm.intr.memcpy"(%25, %24, %23, %26) : (!llvm.ptr<i64>, !llvm.ptr<i64>, i64, i1) -> ()
    llvm.call @external_dce_flag_1() : () -> ()
    %27 = llvm.mlir.constant(0 : index) : i64
    %28 = llvm.mlir.constant(0 : index) : i64
    %29 = llvm.add %27, %28  : i64
    %30 = llvm.getelementptr %7[%29] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %31 = llvm.load %30 : !llvm.ptr<i64>
    %32 = llvm.mlir.constant(1 : i64) : i64
    %33 = llvm.intr.smax(%31, %32)  : (i64, i64) -> i64
    %34 = llvm.sdiv %31, %33  : i64
    %35 = llvm.mlir.constant(-5.844730e-01 : f16) : f16
    %36 = llvm.mlir.constant(2 : i32) : i32
    llvm.return %36 : i32
  }
}

