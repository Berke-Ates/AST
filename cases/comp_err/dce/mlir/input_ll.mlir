module attributes {llvm.data_layout = ""} {
  llvm.func @external_dce_flag_1() attributes {sym_visibility = "private"}
  llvm.func @main() -> i32 {
    %0 = llvm.mlir.constant(2 : i32) : i32
    llvm.call @external_dce_flag_1() : () -> ()
    llvm.return %0 : i32
  }
}

