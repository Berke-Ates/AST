module attributes {llvm.data_layout = ""} {
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @external_dce_flag_1() attributes {sym_visibility = "private"}
  llvm.func @main() -> i32 {
    llvm.call @external_dce_flag_1() : () -> ()
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.constant(100000 : index) : i64
    %2 = llvm.mlir.constant(100000 : index) : i64
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.mlir.constant(10000000000 : index) : i64
    %5 = llvm.mlir.constant(10000000000 : index) : i64
    %6 = llvm.mlir.null : !llvm.ptr<f64>
    %7 = llvm.getelementptr %6[%5] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %8 = llvm.ptrtoint %7 : !llvm.ptr<f64> to i64
    %9 = llvm.call @malloc(%8) : (i64) -> !llvm.ptr<i8>
    %10 = llvm.bitcast %9 : !llvm.ptr<i8> to !llvm.ptr<f64>
    %11 = llvm.mlir.undef : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %12 = llvm.insertvalue %10, %11[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %13 = llvm.insertvalue %10, %12[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %14 = llvm.mlir.constant(0 : index) : i64
    %15 = llvm.insertvalue %14, %13[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %16 = llvm.insertvalue %0, %15[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %17 = llvm.insertvalue %1, %16[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %18 = llvm.insertvalue %2, %17[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %19 = llvm.insertvalue %4, %18[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %20 = llvm.insertvalue %2, %19[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %21 = llvm.insertvalue %3, %20[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %22 = llvm.mlir.constant(0 : index) : i64
    %23 = llvm.mlir.constant(23252 : index) : i64
    %24 = llvm.mlir.constant(39434 : index) : i64
    %25 = llvm.mlir.constant(10000000000 : index) : i64
    %26 = llvm.mul %22, %25  : i64
    %27 = llvm.mlir.constant(100000 : index) : i64
    %28 = llvm.mul %23, %27  : i64
    %29 = llvm.add %26, %28  : i64
    %30 = llvm.add %29, %24  : i64
    %31 = llvm.getelementptr %10[%30] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %32 = llvm.load %31 : !llvm.ptr<f64>
    %33 = llvm.mlir.constant(0 : index) : i64
    %34 = llvm.mlir.constant(10348 : index) : i64
    %35 = llvm.mlir.constant(94387 : index) : i64
    %36 = llvm.mlir.constant(10000000000 : index) : i64
    %37 = llvm.mul %33, %36  : i64
    %38 = llvm.mlir.constant(100000 : index) : i64
    %39 = llvm.mul %34, %38  : i64
    %40 = llvm.add %37, %39  : i64
    %41 = llvm.add %40, %35  : i64
    %42 = llvm.getelementptr %10[%41] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    llvm.store %32, %42 : !llvm.ptr<f64>
    %43 = llvm.mlir.constant(23252 : i32) : i32
    llvm.return %43 : i32
  }
}

