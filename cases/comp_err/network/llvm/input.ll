; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare ptr @malloc(i64)

declare void @free(ptr)

declare void @external_dce_flag_2()

declare void @external_dce_flag_1()

define i32 @main() {
  call void @external_dce_flag_1()
  %1 = alloca i64, i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 1) to i64), align 8
  %2 = insertvalue { ptr, ptr, i64 } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64 } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64 } %3, i64 0, 2
  call void @free(ptr %1)
  %5 = alloca float, i64 ptrtoint (ptr getelementptr (float, ptr null, i32 200000) to i64), align 4
  %6 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } undef, ptr %5, 0
  %7 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %6, ptr %5, 1
  %8 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %7, i64 0, 2
  %9 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %8, i64 100000, 3, 0
  %10 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %9, i64 1, 3, 1
  %11 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %10, i64 2, 3, 2
  %12 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %11, i64 2, 4, 0
  %13 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %12, i64 2, 4, 1
  %14 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %13, i64 1, 4, 2
  %15 = getelementptr i64, ptr %1, i64 0
  %16 = getelementptr i64, ptr %1, i64 0
  call void @llvm.memcpy.p0.p0.i64(ptr %16, ptr %15, i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 1) to i64), i1 false)
  %17 = alloca i64, i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 4) to i64), align 8
  %18 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } undef, ptr %17, 0
  %19 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %18, ptr %17, 1
  %20 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %19, i64 0, 2
  %21 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %20, i64 2, 3, 0
  %22 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %21, i64 2, 3, 1
  %23 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %22, i64 2, 4, 0
  %24 = insertvalue { ptr, ptr, i64, [2 x i64], [2 x i64] } %23, i64 1, 4, 1
  call void @free(ptr %5)
  call void @external_dce_flag_2()
  %25 = getelementptr i64, ptr %17, i64 0
  %26 = getelementptr i64, ptr %17, i64 0
  call void @llvm.memcpy.p0.p0.i64(ptr %26, ptr %25, i64 mul (i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 1) to i64), i64 4), i1 false)
  %27 = getelementptr i64, ptr %1, i64 0
  %28 = getelementptr i64, ptr %1, i64 0
  call void @llvm.memcpy.p0.p0.i64(ptr %28, ptr %27, i64 ptrtoint (ptr getelementptr (i64, ptr null, i32 1) to i64), i1 false)
  call void @free(ptr %17)
  ret i32 0
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

attributes #0 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
