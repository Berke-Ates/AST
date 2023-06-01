module {
  sdfg.sdfg {entry = @init_0} () -> (%arg0: !sdfg.array<i32>){
    %0 = sdfg.alloc {name = "_constant_tmp_27", transient} () : !sdfg.array<i32>
    %1 = sdfg.alloc {name = "_alloc_tmp_24", transient} () : !sdfg.array<2x100000x1xi16>
    %2 = sdfg.alloc {name = "_cmpi_tmp_22", transient} () : !sdfg.array<i1>
    %3 = sdfg.alloc {name = "_extui_tmp_20", transient} () : !sdfg.array<i32>
    %4 = sdfg.alloc {name = "_addi_tmp_17", transient} () : !sdfg.array<i16>
    %5 = sdfg.alloc {name = "_remsi_tmp_15", transient} () : !sdfg.array<i16>
    %6 = sdfg.alloc {name = "_constant_tmp_13", transient} () : !sdfg.array<i16>
    %7 = sdfg.alloc {name = "_constant_tmp_11", transient} () : !sdfg.array<i16>
    %8 = sdfg.alloc {name = "_constant_tmp_9", transient} () : !sdfg.array<index>
    %9 = sdfg.alloc {name = "_constant_tmp_6", transient} () : !sdfg.array<i16>
    %10 = sdfg.alloc {name = "_alloca_tmp_2", transient} () : !sdfg.array<100000x100000x100000xi8>
    sdfg.state @init_0{
    }
    sdfg.state @external_dce_flag_1_1{
      sdfg.tasklet {insert_code = "external_dce_flag_1"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @alloca_init_3{
    }
    sdfg.state @external_dce_flag_2_4{
      sdfg.tasklet {insert_code = "external_dce_flag_2"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @constant_5{
      %11 = sdfg.tasklet () -> (i16){
        %c0_i16 = arith.constant 0 : i16
        sdfg.return %c0_i16 : i16
      }
      sdfg.store %11, %9[] : i16 -> !sdfg.array<i16>
      %12 = sdfg.load %9[] : !sdfg.array<i16> -> i16
    }
    sdfg.state @external_dce_flag_3_7{
      sdfg.tasklet {insert_code = "external_dce_flag_3"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @constant_8{
      %11 = sdfg.tasklet () -> (index){
        %c0 = arith.constant 0 : index
        sdfg.return %c0 : index
      }
      sdfg.store %11, %8[] : index -> !sdfg.array<index>
      %12 = sdfg.load %8[] : !sdfg.array<index> -> index
    }
    sdfg.state @constant_10{
      %11 = sdfg.tasklet () -> (i16){
        %c1_i16 = arith.constant 1 : i16
        sdfg.return %c1_i16 : i16
      }
      sdfg.store %11, %7[] : i16 -> !sdfg.array<i16>
      %12 = sdfg.load %7[] : !sdfg.array<i16> -> i16
    }
    sdfg.state @constant_12{
      %11 = sdfg.tasklet () -> (i16){
        %c1_i16 = arith.constant 1 : i16
        sdfg.return %c1_i16 : i16
      }
      sdfg.store %11, %6[] : i16 -> !sdfg.array<i16>
      %12 = sdfg.load %6[] : !sdfg.array<i16> -> i16
    }
    sdfg.state @remsi_14{
      %11 = sdfg.load %9[] : !sdfg.array<i16> -> i16
      %12 = sdfg.load %6[] : !sdfg.array<i16> -> i16
      %13 = sdfg.tasklet (%11 as %arg1: i16, %12 as %arg2: i16) -> (i16){
        %15 = arith.remsi %arg1, %arg2 : i16
        sdfg.return %15 : i16
      }
      sdfg.store %13, %5[] : i16 -> !sdfg.array<i16>
      %14 = sdfg.load %5[] : !sdfg.array<i16> -> i16
    }
    sdfg.state @addi_16{
      %11 = sdfg.load %6[] : !sdfg.array<i16> -> i16
      %12 = sdfg.load %7[] : !sdfg.array<i16> -> i16
      %13 = sdfg.tasklet (%11 as %arg1: i16, %12 as %arg2: i16) -> (i16){
        %15 = arith.addi %arg1, %arg2 : i16
        sdfg.return %15 : i16
      }
      sdfg.store %13, %4[] : i16 -> !sdfg.array<i16>
      %14 = sdfg.load %4[] : !sdfg.array<i16> -> i16
    }
    sdfg.state @external_dce_flag_4_18{
      sdfg.tasklet {insert_code = "external_dce_flag_4"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @extui_19{
      %11 = sdfg.load %6[] : !sdfg.array<i16> -> i16
      %12 = sdfg.tasklet (%11 as %arg1: i16) -> (i32){
        %14 = arith.extui %arg1 : i16 to i32
        sdfg.return %14 : i32
      }
      sdfg.store %12, %3[] : i32 -> !sdfg.array<i32>
      %13 = sdfg.load %3[] : !sdfg.array<i32> -> i32
    }
    sdfg.state @cmpi_21{
      %11 = sdfg.load %5[] : !sdfg.array<i16> -> i16
      %12 = sdfg.load %4[] : !sdfg.array<i16> -> i16
      %13 = sdfg.tasklet (%11 as %arg1: i16, %12 as %arg2: i16) -> (i1){
        %15 = arith.cmpi ult, %arg1, %arg2 : i16
        sdfg.return %15 : i1
      }
      sdfg.store %13, %2[] : i1 -> !sdfg.array<i1>
      %14 = sdfg.load %2[] : !sdfg.array<i1> -> i1
    }
    sdfg.state @external_dce_flag_5_23{
      sdfg.tasklet {insert_code = "external_dce_flag_5"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @alloc_init_25{
    }
    sdfg.state @constant_26{
      %11 = sdfg.tasklet () -> (i32){
        %c0_i32 = arith.constant 0 : i32
        sdfg.return %c0_i32 : i32
      }
      sdfg.store %11, %0[] : i32 -> !sdfg.array<i32>
      %12 = sdfg.load %0[] : !sdfg.array<i32> -> i32
    }
    sdfg.state @return_28{
      %11 = sdfg.load %0[] : !sdfg.array<i32> -> i32
      sdfg.store %11, %arg0[] : i32 -> !sdfg.array<i32>
    }
    sdfg.edge {assign = [], condition = "1"} @init_0 -> @external_dce_flag_1_1
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_1_1 -> @alloca_init_3
    sdfg.edge {assign = [], condition = "1"} @alloca_init_3 -> @external_dce_flag_2_4
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_2_4 -> @constant_5
    sdfg.edge {assign = [], condition = "1"} @constant_5 -> @external_dce_flag_3_7
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_3_7 -> @constant_8
    sdfg.edge {assign = [], condition = "1"} @constant_8 -> @constant_10
    sdfg.edge {assign = [], condition = "1"} @constant_10 -> @constant_12
    sdfg.edge {assign = [], condition = "1"} @constant_12 -> @remsi_14
    sdfg.edge {assign = [], condition = "1"} @remsi_14 -> @addi_16
    sdfg.edge {assign = [], condition = "1"} @addi_16 -> @external_dce_flag_4_18
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_4_18 -> @extui_19
    sdfg.edge {assign = [], condition = "1"} @extui_19 -> @cmpi_21
    sdfg.edge {assign = [], condition = "1"} @cmpi_21 -> @external_dce_flag_5_23
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_5_23 -> @alloc_init_25
    sdfg.edge {assign = [], condition = "1"} @alloc_init_25 -> @constant_26
    sdfg.edge {assign = [], condition = "1"} @constant_26 -> @return_28
  }
}

