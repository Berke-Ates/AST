; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare ptr @malloc(i64)

declare void @free(ptr)

declare void @external_dce_flag_1()

define i32 @main() {
  call void @external_dce_flag_1()
  %1 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (double, ptr null, i64 10000000000) to i64))
  %2 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4, i64 1, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5, i64 100000, 3, 1
  %7 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %6, i64 100000, 3, 2
  %8 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %7, i64 10000000000, 4, 0
  %9 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %8, i64 100000, 4, 1
  %10 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %9, i64 1, 4, 2
  %11 = getelementptr double, ptr %1, i64 2325239434
  %12 = load double, ptr %11, align 8
  %13 = getelementptr double, ptr %1, i64 1034894387
  store double %12, ptr %13, align 8
  ret i32 23252
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
