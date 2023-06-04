module attributes {llvm.data_layout = ""} {
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @external_dce_flag_1() attributes {sym_visibility = "private"}
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(23252 : i32) : i32
    %1 = llvm.mlir.constant(94387 : index) : i64
    %2 = llvm.mlir.constant(10348 : index) : i64
    %3 = llvm.mlir.constant(39434 : index) : i64
    %4 = llvm.mlir.constant(23252 : index) : i64
    %5 = llvm.mlir.constant(0 : index) : i64
    llvm.call @external_dce_flag_1() : () -> ()
    %6 = llvm.mlir.constant(1 : index) : i64
    %7 = llvm.mlir.constant(100000 : index) : i64
    %8 = llvm.mlir.constant(100000 : index) : i64
    %9 = llvm.mlir.constant(1 : index) : i64
    %10 = llvm.mlir.constant(10000000000 : index) : i64
    %11 = llvm.mlir.constant(10000000000 : index) : i64
    %12 = llvm.mlir.null : !llvm.ptr<f64>
    %13 = llvm.getelementptr %12[%11] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %14 = llvm.ptrtoint %13 : !llvm.ptr<f64> to i64
    %15 = llvm.call @malloc(%14) : (i64) -> !llvm.ptr<i8>
    %16 = llvm.bitcast %15 : !llvm.ptr<i8> to !llvm.ptr<f64>
    %17 = llvm.mlir.undef : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)>
    %18 = llvm.insertvalue %16, %17[0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %19 = llvm.insertvalue %16, %18[1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %20 = llvm.mlir.constant(0 : index) : i64
    %21 = llvm.insertvalue %20, %19[2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %22 = llvm.insertvalue %6, %21[3, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %23 = llvm.insertvalue %7, %22[3, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %24 = llvm.insertvalue %8, %23[3, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %25 = llvm.insertvalue %10, %24[4, 0] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %26 = llvm.insertvalue %8, %25[4, 1] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %27 = llvm.insertvalue %9, %26[4, 2] : !llvm.struct<(ptr<f64>, ptr<f64>, i64, array<3 x i64>, array<3 x i64>)> 
    %28 = llvm.mlir.constant(10000000000 : index) : i64
    %29 = llvm.mul %5, %28  : i64
    %30 = llvm.mlir.constant(100000 : index) : i64
    %31 = llvm.mul %4, %30  : i64
    %32 = llvm.add %29, %31  : i64
    %33 = llvm.add %32, %3  : i64
    %34 = llvm.getelementptr %16[%33] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    %35 = llvm.load %34 : !llvm.ptr<f64>
    %36 = llvm.mlir.constant(10000000000 : index) : i64
    %37 = llvm.mul %5, %36  : i64
    %38 = llvm.mlir.constant(100000 : index) : i64
    %39 = llvm.mul %2, %38  : i64
    %40 = llvm.add %37, %39  : i64
    %41 = llvm.add %40, %1  : i64
    %42 = llvm.getelementptr %16[%41] : (!llvm.ptr<f64>, i64) -> !llvm.ptr<f64>
    llvm.store %35, %42 : !llvm.ptr<f64>
    llvm.return %0 : i32
  }
}

