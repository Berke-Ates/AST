module attributes {llvm.data_layout = ""} {
  llvm.func @external_dce_flag_5() attributes {sym_visibility = "private"}
  llvm.func @external_dce_flag_4() attributes {sym_visibility = "private"}
  llvm.func @external_dce_flag_3() attributes {sym_visibility = "private"}
  llvm.func @external_dce_flag_2() attributes {sym_visibility = "private"}
  llvm.func @external_dce_flag_1() attributes {sym_visibility = "private"}
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(0 : i32) : i32
    llvm.call @external_dce_flag_1() : () -> ()
    llvm.call @external_dce_flag_2() : () -> ()
    llvm.call @external_dce_flag_3() : () -> ()
    llvm.call @external_dce_flag_4() : () -> ()
    llvm.call @external_dce_flag_5() : () -> ()
    llvm.return %0 : i32
  }
}

