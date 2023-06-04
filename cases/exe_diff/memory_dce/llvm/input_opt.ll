; ModuleID = './out/smith_2/llvm/input.ll'
source_filename = "LLVMDialectModule"

declare void @external_dce_flag_1() local_unnamed_addr

define i32 @main() local_unnamed_addr {
  tail call void @external_dce_flag_1()
  ret i32 23252
}

!llvm.module.flags = !{!0}

!0 = !{i32 2, !"Debug Info Version", i32 3}
