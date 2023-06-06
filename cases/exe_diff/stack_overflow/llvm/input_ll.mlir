module attributes {llvm.data_layout = ""} {
  llvm.func @malloc(i64) -> !llvm.ptr<i8>
  llvm.func @external_dce_flag_5() attributes {sym_visibility = "private"}
  llvm.func @external_dce_flag_4() attributes {sym_visibility = "private"}
  llvm.func @external_dce_flag_3() attributes {sym_visibility = "private"}
  llvm.func @external_dce_flag_2() attributes {sym_visibility = "private"}
  llvm.func @external_dce_flag_1() attributes {sym_visibility = "private"}
  llvm.func @main() -> i32 {
    llvm.call @external_dce_flag_1() : () -> ()
    %0 = llvm.mlir.constant(100000 : index) : i64
    %1 = llvm.mlir.constant(100000 : index) : i64
    %2 = llvm.mlir.constant(100000 : index) : i64
    %3 = llvm.mlir.constant(1 : index) : i64
    %4 = llvm.mlir.constant(10000000000 : index) : i64
    %5 = llvm.mlir.constant(1000000000000000 : index) : i64
    %6 = llvm.mlir.null : !llvm.ptr<i8>
    %7 = llvm.getelementptr %6[%5] : (!llvm.ptr<i8>, i64) -> !llvm.ptr<i8>
    %8 = llvm.ptrtoint %7 : !llvm.ptr<i8> to i64
    %9 = llvm.alloca %8 x i8 : (i64) -> !llvm.ptr<i8>
    %10 = llvm.mlir.undef : !llvm.struct<(ptr<i8>, ptr<i8>, i64, array<3 x i64>, array<3 x i64>)>
    %11 = llvm.insertvalue %9, %10[0] : !llvm.struct<(ptr<i8>, ptr<i8>, i64, array<3 x i64>, array<3 x i64>)> 
    %12 = llvm.insertvalue %9, %11[1] : !llvm.struct<(ptr<i8>, ptr<i8>, i64, array<3 x i64>, array<3 x i64>)> 
    %13 = llvm.mlir.constant(0 : index) : i64
    %14 = llvm.insertvalue %13, %12[2] : !llvm.struct<(ptr<i8>, ptr<i8>, i64, array<3 x i64>, array<3 x i64>)> 
    %15 = llvm.insertvalue %0, %14[3, 0] : !llvm.struct<(ptr<i8>, ptr<i8>, i64, array<3 x i64>, array<3 x i64>)> 
    %16 = llvm.insertvalue %1, %15[3, 1] : !llvm.struct<(ptr<i8>, ptr<i8>, i64, array<3 x i64>, array<3 x i64>)> 
    %17 = llvm.insertvalue %2, %16[3, 2] : !llvm.struct<(ptr<i8>, ptr<i8>, i64, array<3 x i64>, array<3 x i64>)> 
    %18 = llvm.insertvalue %4, %17[4, 0] : !llvm.struct<(ptr<i8>, ptr<i8>, i64, array<3 x i64>, array<3 x i64>)> 
    %19 = llvm.insertvalue %2, %18[4, 1] : !llvm.struct<(ptr<i8>, ptr<i8>, i64, array<3 x i64>, array<3 x i64>)> 
    %20 = llvm.insertvalue %3, %19[4, 2] : !llvm.struct<(ptr<i8>, ptr<i8>, i64, array<3 x i64>, array<3 x i64>)> 
    llvm.call @external_dce_flag_2() : () -> ()
    %21 = llvm.mlir.constant(0 : i16) : i16
    llvm.call @external_dce_flag_3() : () -> ()
    %22 = llvm.mlir.constant(0 : index) : i64
    %23 = llvm.mlir.constant(1 : i16) : i16
    %24 = llvm.mlir.constant(1 : i16) : i16
    %25 = llvm.srem %21, %24  : i16
    %26 = llvm.add %24, %23  : i16
    llvm.call @external_dce_flag_4() : () -> ()
    %27 = llvm.zext %24 : i16 to i32
    %28 = llvm.icmp "ult" %25, %26 : i16
    llvm.call @external_dce_flag_5() : () -> ()
    %29 = llvm.mlir.constant(2 : index) : i64
    %30 = llvm.mlir.constant(100000 : index) : i64
    %31 = llvm.mlir.constant(1 : index) : i64
    %32 = llvm.mlir.constant(1 : index) : i64
    %33 = llvm.mlir.constant(200000 : index) : i64
    %34 = llvm.mlir.null : !llvm.ptr<i16>
    %35 = llvm.getelementptr %34[200000] : (!llvm.ptr<i16>) -> !llvm.ptr<i16>
    %36 = llvm.ptrtoint %35 : !llvm.ptr<i16> to i64
    %37 = llvm.call @malloc(%36) : (i64) -> !llvm.ptr<i8>
    %38 = llvm.bitcast %37 : !llvm.ptr<i8> to !llvm.ptr<i16>
    %39 = llvm.mlir.undef : !llvm.struct<(ptr<i16>, ptr<i16>, i64, array<3 x i64>, array<3 x i64>)>
    %40 = llvm.insertvalue %38, %39[0] : !llvm.struct<(ptr<i16>, ptr<i16>, i64, array<3 x i64>, array<3 x i64>)> 
    %41 = llvm.insertvalue %38, %40[1] : !llvm.struct<(ptr<i16>, ptr<i16>, i64, array<3 x i64>, array<3 x i64>)> 
    %42 = llvm.mlir.constant(0 : index) : i64
    %43 = llvm.insertvalue %42, %41[2] : !llvm.struct<(ptr<i16>, ptr<i16>, i64, array<3 x i64>, array<3 x i64>)> 
    %44 = llvm.insertvalue %29, %43[3, 0] : !llvm.struct<(ptr<i16>, ptr<i16>, i64, array<3 x i64>, array<3 x i64>)> 
    %45 = llvm.insertvalue %30, %44[3, 1] : !llvm.struct<(ptr<i16>, ptr<i16>, i64, array<3 x i64>, array<3 x i64>)> 
    %46 = llvm.insertvalue %31, %45[3, 2] : !llvm.struct<(ptr<i16>, ptr<i16>, i64, array<3 x i64>, array<3 x i64>)> 
    %47 = llvm.insertvalue %30, %46[4, 0] : !llvm.struct<(ptr<i16>, ptr<i16>, i64, array<3 x i64>, array<3 x i64>)> 
    %48 = llvm.insertvalue %31, %47[4, 1] : !llvm.struct<(ptr<i16>, ptr<i16>, i64, array<3 x i64>, array<3 x i64>)> 
    %49 = llvm.insertvalue %32, %48[4, 2] : !llvm.struct<(ptr<i16>, ptr<i16>, i64, array<3 x i64>, array<3 x i64>)> 
    %50 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %50 : i32
  }
}

