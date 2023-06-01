module {
  sdfg.sdfg {entry = @init_0} () -> (%arg0: !sdfg.array<i32>){
    %0 = sdfg.alloc {name = "_extsi_tmp_33", transient} () : !sdfg.array<i64>
    %1 = sdfg.alloc {name = "_addi_tmp_31", transient} () : !sdfg.array<i32>
    %2 = sdfg.alloc {name = "_extsi_tmp_29", transient} () : !sdfg.array<i32>
    %3 = sdfg.alloc {name = "_cmpi_tmp_27", transient} () : !sdfg.array<i1>
    %4 = sdfg.alloc {name = "_extsi_tmp_25", transient} () : !sdfg.array<i8>
    %5 = sdfg.alloc {name = "_constant_tmp_23", transient} () : !sdfg.array<i8>
    %6 = sdfg.alloc {name = "_muli_tmp_21", transient} () : !sdfg.array<i64>
    %7 = sdfg.alloc {name = "_constant_tmp_19", transient} () : !sdfg.array<i64>
    %8 = sdfg.alloc {name = "_remui_tmp_17", transient} () : !sdfg.array<i64>
    %9 = sdfg.alloc {name = "_addi_tmp_14", transient} () : !sdfg.array<i64>
    %10 = sdfg.alloc {name = "_constant_tmp_12", transient} () : !sdfg.array<i1>
    %11 = sdfg.alloc {name = "_remui_tmp_10", transient} () : !sdfg.array<i64>
    %12 = sdfg.alloc {name = "_constant_tmp_8", transient} () : !sdfg.array<i64>
    %13 = sdfg.alloc {name = "_constant_tmp_6", transient} () : !sdfg.array<i64>
    %14 = sdfg.alloc {name = "_alloca_tmp_3", transient} () : !sdfg.array<2xindex>
    %15 = sdfg.alloc {name = "_constant_tmp_2", transient} () : !sdfg.array<i8>
    sdfg.state @init_0{
    }
    sdfg.state @constant_1{
      %16 = sdfg.tasklet () -> (i8){
        %c-2_i8 = arith.constant -2 : i8
        sdfg.return %c-2_i8 : i8
      }
      sdfg.store %16, %15[] : i8 -> !sdfg.array<i8>
      %17 = sdfg.load %15[] : !sdfg.array<i8> -> i8
    }
    sdfg.state @alloca_init_4{
    }
    sdfg.state @constant_5{
      %16 = sdfg.tasklet () -> (i64){
        %c-2_i64 = arith.constant -2 : i64
        sdfg.return %c-2_i64 : i64
      }
      sdfg.store %16, %13[] : i64 -> !sdfg.array<i64>
      %17 = sdfg.load %13[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @constant_7{
      %16 = sdfg.tasklet () -> (i64){
        %c-2_i64 = arith.constant -2 : i64
        sdfg.return %c-2_i64 : i64
      }
      sdfg.store %16, %12[] : i64 -> !sdfg.array<i64>
      %17 = sdfg.load %12[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @remui_9{
      %16 = sdfg.load %13[] : !sdfg.array<i64> -> i64
      %17 = sdfg.load %12[] : !sdfg.array<i64> -> i64
      %18 = sdfg.tasklet (%16 as %arg1: i64, %17 as %arg2: i64) -> (i64){
        %20 = arith.remui %arg1, %arg2 : i64
        sdfg.return %20 : i64
      }
      sdfg.store %18, %11[] : i64 -> !sdfg.array<i64>
      %19 = sdfg.load %11[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @constant_11{
      %16 = sdfg.tasklet () -> (i1){
        %false = arith.constant false
        sdfg.return %false : i1
      }
      sdfg.store %16, %10[] : i1 -> !sdfg.array<i1>
      %17 = sdfg.load %10[] : !sdfg.array<i1> -> i1
    }
    sdfg.state @addi_13{
      %16 = sdfg.load %13[] : !sdfg.array<i64> -> i64
      %17 = sdfg.load %12[] : !sdfg.array<i64> -> i64
      %18 = sdfg.tasklet (%16 as %arg1: i64, %17 as %arg2: i64) -> (i64){
        %20 = arith.addi %arg1, %arg2 : i64
        sdfg.return %20 : i64
      }
      sdfg.store %18, %9[] : i64 -> !sdfg.array<i64>
      %19 = sdfg.load %9[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @external_dce_flag_1_15{
      sdfg.tasklet {insert_code = "external_dce_flag_1"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @remui_16{
      %16 = sdfg.load %11[] : !sdfg.array<i64> -> i64
      %17 = sdfg.load %11[] : !sdfg.array<i64> -> i64
      %18 = sdfg.tasklet (%16 as %arg1: i64, %17 as %arg2: i64) -> (i64){
        %20 = arith.remui %arg2, %arg2 : i64
        sdfg.return %20 : i64
      }
      sdfg.store %18, %8[] : i64 -> !sdfg.array<i64>
      %19 = sdfg.load %8[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @constant_18{
      %16 = sdfg.tasklet () -> (i64){
        %c-2_i64 = arith.constant -2 : i64
        sdfg.return %c-2_i64 : i64
      }
      sdfg.store %16, %7[] : i64 -> !sdfg.array<i64>
      %17 = sdfg.load %7[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @muli_20{
      %16 = sdfg.load %13[] : !sdfg.array<i64> -> i64
      %17 = sdfg.load %13[] : !sdfg.array<i64> -> i64
      %18 = sdfg.tasklet (%16 as %arg1: i64, %17 as %arg2: i64) -> (i64){
        %20 = arith.muli %arg2, %arg2 : i64
        sdfg.return %20 : i64
      }
      sdfg.store %18, %6[] : i64 -> !sdfg.array<i64>
      %19 = sdfg.load %6[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @constant_22{
      %16 = sdfg.tasklet () -> (i8){
        %c0_i8 = arith.constant 0 : i8
        sdfg.return %c0_i8 : i8
      }
      sdfg.store %16, %5[] : i8 -> !sdfg.array<i8>
      %17 = sdfg.load %5[] : !sdfg.array<i8> -> i8
    }
    sdfg.state @extsi_24{
      %16 = sdfg.load %10[] : !sdfg.array<i1> -> i1
      %17 = sdfg.tasklet (%16 as %arg1: i1) -> (i8){
        %19 = arith.extsi %arg1 : i1 to i8
        sdfg.return %19 : i8
      }
      sdfg.store %17, %4[] : i8 -> !sdfg.array<i8>
      %18 = sdfg.load %4[] : !sdfg.array<i8> -> i8
    }
    sdfg.state @cmpi_26{
      %16 = sdfg.load %7[] : !sdfg.array<i64> -> i64
      %17 = sdfg.load %6[] : !sdfg.array<i64> -> i64
      %18 = sdfg.tasklet (%16 as %arg1: i64, %17 as %arg2: i64) -> (i1){
        %20 = arith.cmpi ule, %arg1, %arg2 : i64
        sdfg.return %20 : i1
      }
      sdfg.store %18, %3[] : i1 -> !sdfg.array<i1>
      %19 = sdfg.load %3[] : !sdfg.array<i1> -> i1
    }
    sdfg.state @extsi_28{
      %16 = sdfg.load %3[] : !sdfg.array<i1> -> i1
      %17 = sdfg.tasklet (%16 as %arg1: i1) -> (i32){
        %19 = arith.extsi %arg1 : i1 to i32
        sdfg.return %19 : i32
      }
      sdfg.store %17, %2[] : i32 -> !sdfg.array<i32>
      %18 = sdfg.load %2[] : !sdfg.array<i32> -> i32
    }
    sdfg.state @addi_30{
      %16 = sdfg.load %2[] : !sdfg.array<i32> -> i32
      %17 = sdfg.load %2[] : !sdfg.array<i32> -> i32
      %18 = sdfg.tasklet (%16 as %arg1: i32, %17 as %arg2: i32) -> (i32){
        %20 = arith.addi %arg2, %arg2 : i32
        sdfg.return %20 : i32
      }
      sdfg.store %18, %1[] : i32 -> !sdfg.array<i32>
      %19 = sdfg.load %1[] : !sdfg.array<i32> -> i32
    }
    sdfg.state @extsi_32{
      %16 = sdfg.load %3[] : !sdfg.array<i1> -> i1
      %17 = sdfg.tasklet (%16 as %arg1: i1) -> (i64){
        %19 = arith.extsi %arg1 : i1 to i64
        sdfg.return %19 : i64
      }
      sdfg.store %17, %0[] : i64 -> !sdfg.array<i64>
      %18 = sdfg.load %0[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @external_dce_flag_2_34{
      sdfg.tasklet {insert_code = "external_dce_flag_2"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @return_35{
      %16 = sdfg.load %1[] : !sdfg.array<i32> -> i32
      sdfg.store %16, %arg0[] : i32 -> !sdfg.array<i32>
    }
    sdfg.edge {assign = [], condition = "1"} @init_0 -> @constant_1
    sdfg.edge {assign = [], condition = "1"} @constant_1 -> @alloca_init_4
    sdfg.edge {assign = [], condition = "1"} @alloca_init_4 -> @constant_5
    sdfg.edge {assign = [], condition = "1"} @constant_5 -> @constant_7
    sdfg.edge {assign = [], condition = "1"} @constant_7 -> @remui_9
    sdfg.edge {assign = [], condition = "1"} @remui_9 -> @constant_11
    sdfg.edge {assign = [], condition = "1"} @constant_11 -> @addi_13
    sdfg.edge {assign = [], condition = "1"} @addi_13 -> @external_dce_flag_1_15
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_1_15 -> @remui_16
    sdfg.edge {assign = [], condition = "1"} @remui_16 -> @constant_18
    sdfg.edge {assign = [], condition = "1"} @constant_18 -> @muli_20
    sdfg.edge {assign = [], condition = "1"} @muli_20 -> @constant_22
    sdfg.edge {assign = [], condition = "1"} @constant_22 -> @extsi_24
    sdfg.edge {assign = [], condition = "1"} @extsi_24 -> @cmpi_26
    sdfg.edge {assign = [], condition = "1"} @cmpi_26 -> @extsi_28
    sdfg.edge {assign = [], condition = "1"} @extsi_28 -> @addi_30
    sdfg.edge {assign = [], condition = "1"} @addi_30 -> @extsi_32
    sdfg.edge {assign = [], condition = "1"} @extsi_32 -> @external_dce_flag_2_34
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_2_34 -> @return_35
  }
}

