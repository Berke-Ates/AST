module attributes {llvm.data_layout = ""} {
  llvm.func @free(!llvm.ptr<i8>)
  llvm.func @external_dce_flag_2() attributes {sym_visibility = "private"}
  llvm.func @external_dce_flag_1() attributes {sym_visibility = "private"}
  llvm.func @main() -> i32 {
    llvm.call @external_dce_flag_1() : () -> ()
    %0 = llvm.mlir.constant(1 : index) : i64
    %1 = llvm.mlir.null : !llvm.ptr<i64>
    %2 = llvm.getelementptr %1[1] : (!llvm.ptr<i64>) -> !llvm.ptr<i64>
    %3 = llvm.ptrtoint %2 : !llvm.ptr<i64> to i64
    %4 = llvm.alloca %3 x i64 : (i64) -> !llvm.ptr<i64>
    %5 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64)>
    %6 = llvm.insertvalue %4, %5[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)> 
    %7 = llvm.insertvalue %4, %6[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)> 
    %8 = llvm.mlir.constant(0 : index) : i64
    %9 = llvm.insertvalue %8, %7[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64)> 
    %10 = llvm.bitcast %4 : !llvm.ptr<i64> to !llvm.ptr<i8>
    llvm.call @free(%10) : (!llvm.ptr<i8>) -> ()
    %11 = llvm.mlir.constant(100000 : index) : i64
    %12 = llvm.mlir.constant(1 : index) : i64
    %13 = llvm.mlir.constant(2 : index) : i64
    %14 = llvm.mlir.constant(1 : index) : i64
    %15 = llvm.mlir.constant(2 : index) : i64
    %16 = llvm.mlir.constant(200000 : index) : i64
    %17 = llvm.mlir.null : !llvm.ptr<f32>
    %18 = llvm.getelementptr %17[200000] : (!llvm.ptr<f32>) -> !llvm.ptr<f32>
    %19 = llvm.ptrtoint %18 : !llvm.ptr<f32> to i64
    %20 = llvm.alloca %19 x f32 : (i64) -> !llvm.ptr<f32>
    %21 = llvm.mlir.undef : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)>
    %22 = llvm.insertvalue %20, %21[0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)> 
    %23 = llvm.insertvalue %20, %22[1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)> 
    %24 = llvm.mlir.constant(0 : index) : i64
    %25 = llvm.insertvalue %24, %23[2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)> 
    %26 = llvm.insertvalue %11, %25[3, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)> 
    %27 = llvm.insertvalue %12, %26[3, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)> 
    %28 = llvm.insertvalue %13, %27[3, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)> 
    %29 = llvm.insertvalue %15, %28[4, 0] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)> 
    %30 = llvm.insertvalue %13, %29[4, 1] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)> 
    %31 = llvm.insertvalue %14, %30[4, 2] : !llvm.struct<(ptr<f32>, ptr<f32>, i64, array<3 x i64>, array<3 x i64>)> 
    %32 = llvm.mlir.constant(1 : index) : i64
    %33 = llvm.mlir.null : !llvm.ptr<i64>
    %34 = llvm.getelementptr %33[1] : (!llvm.ptr<i64>) -> !llvm.ptr<i64>
    %35 = llvm.ptrtoint %34 : !llvm.ptr<i64> to i64
    %36 = llvm.mul %32, %35  : i64
    %37 = llvm.getelementptr %4[%8] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %38 = llvm.getelementptr %4[%8] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %39 = llvm.mlir.constant(false) : i1
    "llvm.intr.memcpy"(%38, %37, %36, %39) : (!llvm.ptr<i64>, !llvm.ptr<i64>, i64, i1) -> ()
    %40 = llvm.mlir.constant(2 : index) : i64
    %41 = llvm.mlir.constant(2 : index) : i64
    %42 = llvm.mlir.constant(1 : index) : i64
    %43 = llvm.mlir.constant(4 : index) : i64
    %44 = llvm.mlir.null : !llvm.ptr<i64>
    %45 = llvm.getelementptr %44[4] : (!llvm.ptr<i64>) -> !llvm.ptr<i64>
    %46 = llvm.ptrtoint %45 : !llvm.ptr<i64> to i64
    %47 = llvm.alloca %46 x i64 : (i64) -> !llvm.ptr<i64>
    %48 = llvm.mlir.undef : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)>
    %49 = llvm.insertvalue %47, %48[0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %50 = llvm.insertvalue %47, %49[1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %51 = llvm.mlir.constant(0 : index) : i64
    %52 = llvm.insertvalue %51, %50[2] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %53 = llvm.insertvalue %40, %52[3, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %54 = llvm.insertvalue %41, %53[3, 1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %55 = llvm.insertvalue %41, %54[4, 0] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %56 = llvm.insertvalue %42, %55[4, 1] : !llvm.struct<(ptr<i64>, ptr<i64>, i64, array<2 x i64>, array<2 x i64>)> 
    %57 = llvm.bitcast %20 : !llvm.ptr<f32> to !llvm.ptr<i8>
    llvm.call @free(%57) : (!llvm.ptr<i8>) -> ()
    llvm.call @external_dce_flag_2() : () -> ()
    %58 = llvm.mlir.constant(1 : index) : i64
    %59 = llvm.mul %58, %40  : i64
    %60 = llvm.mul %59, %41  : i64
    %61 = llvm.mlir.null : !llvm.ptr<i64>
    %62 = llvm.getelementptr %61[1] : (!llvm.ptr<i64>) -> !llvm.ptr<i64>
    %63 = llvm.ptrtoint %62 : !llvm.ptr<i64> to i64
    %64 = llvm.mul %60, %63  : i64
    %65 = llvm.getelementptr %47[%51] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %66 = llvm.getelementptr %47[%51] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %67 = llvm.mlir.constant(false) : i1
    "llvm.intr.memcpy"(%66, %65, %64, %67) : (!llvm.ptr<i64>, !llvm.ptr<i64>, i64, i1) -> ()
    %68 = llvm.mlir.constant(1 : index) : i64
    %69 = llvm.mlir.null : !llvm.ptr<i64>
    %70 = llvm.getelementptr %69[1] : (!llvm.ptr<i64>) -> !llvm.ptr<i64>
    %71 = llvm.ptrtoint %70 : !llvm.ptr<i64> to i64
    %72 = llvm.mul %68, %71  : i64
    %73 = llvm.getelementptr %4[%8] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %74 = llvm.getelementptr %4[%8] : (!llvm.ptr<i64>, i64) -> !llvm.ptr<i64>
    %75 = llvm.mlir.constant(false) : i1
    "llvm.intr.memcpy"(%74, %73, %72, %75) : (!llvm.ptr<i64>, !llvm.ptr<i64>, i64, i1) -> ()
    %76 = llvm.mlir.constant(1 : i64) : i64
    %77 = llvm.bitcast %47 : !llvm.ptr<i64> to !llvm.ptr<i8>
    llvm.call @free(%77) : (!llvm.ptr<i8>) -> ()
    %78 = llvm.mlir.constant(0 : i16) : i16
    %79 = llvm.mlir.constant(0 : i64) : i64
    %80 = llvm.mlir.constant(0 : i32) : i32
    llvm.return %80 : i32
  }
}

