; ModuleID = 'LLVMDialectModule'
source_filename = "LLVMDialectModule"

declare ptr @malloc(i64)

declare void @free(ptr)

declare void @external_dce_flag_5()

declare void @external_dce_flag_4()

declare void @external_dce_flag_3()

declare void @external_dce_flag_2()

declare void @external_dce_flag_1()

define i32 @main() {
  call void @external_dce_flag_1()
  %1 = alloca i8, i64 ptrtoint (ptr getelementptr (i8, ptr null, i64 1000000000000000) to i64), align 1
  %2 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } undef, ptr %1, 0
  %3 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %2, ptr %1, 1
  %4 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %3, i64 0, 2
  %5 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %4, i64 100000, 3, 0
  %6 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %5, i64 100000, 3, 1
  %7 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %6, i64 100000, 3, 2
  %8 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %7, i64 10000000000, 4, 0
  %9 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %8, i64 100000, 4, 1
  %10 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %9, i64 1, 4, 2
  call void @external_dce_flag_2()
  call void @external_dce_flag_3()
  call void @external_dce_flag_4()
  call void @external_dce_flag_5()
  %11 = call ptr @malloc(i64 ptrtoint (ptr getelementptr (i16, ptr null, i32 200000) to i64))
  %12 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } undef, ptr %11, 0
  %13 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %12, ptr %11, 1
  %14 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %13, i64 0, 2
  %15 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %14, i64 2, 3, 0
  %16 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %15, i64 100000, 3, 1
  %17 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %16, i64 1, 3, 2
  %18 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %17, i64 100000, 4, 0
  %19 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %18, i64 1, 4, 1
  %20 = insertvalue { ptr, ptr, i64, [3 x i64], [3 x i64] } %19, i64 1, 4, 2
  ret i32 0
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
