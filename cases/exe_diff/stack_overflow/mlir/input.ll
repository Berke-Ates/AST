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
  call void @external_dce_flag_2()
  call void @external_dce_flag_3()
  call void @external_dce_flag_4()
  call void @external_dce_flag_5()
  ret i32 0
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
