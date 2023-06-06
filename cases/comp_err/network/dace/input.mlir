module {
  sdfg.sdfg {entry = @init_0} () -> (%arg0: !sdfg.array<i32>){
    %0 = sdfg.alloc {name = "_constant_tmp_19", transient} () : !sdfg.array<i32>
    %1 = sdfg.alloc {name = "_constant_tmp_17", transient} () : !sdfg.array<i64>
    %2 = sdfg.alloc {name = "_constant_tmp_15", transient} () : !sdfg.array<i16>
    %3 = sdfg.alloc {name = "_constant_tmp_13", transient} () : !sdfg.array<i64>
    %4 = sdfg.alloc {name = "_alloca_tmp_7", transient} () : !sdfg.array<2x2xindex>
    %5 = sdfg.alloc {name = "_alloca_tmp_4", transient} () : !sdfg.array<100000x1x2xf32>
    %6 = sdfg.alloc {name = "_alloca_tmp_2", transient} () : !sdfg.array<index>
    sdfg.state @init_0{
    }
    sdfg.state @external_dce_flag_1_1{
      sdfg.tasklet {insert_code = "external_dce_flag_1"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @alloca_init_3{
    }
    sdfg.state @alloca_init_5{
    }
    sdfg.state @copy_6{
      sdfg.copy %6 -> %6 : !sdfg.array<index>
    }
    sdfg.state @alloca_init_8{
    }
    sdfg.state @external_dce_flag_2_9{
      sdfg.tasklet {insert_code = "external_dce_flag_2"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @copy_10{
      sdfg.copy %4 -> %4 : !sdfg.array<2x2xindex>
    }
    sdfg.state @copy_11{
      sdfg.copy %6 -> %6 : !sdfg.array<index>
    }
    sdfg.state @constant_12{
      %7 = sdfg.tasklet () -> (i64){
        %c1_i64 = arith.constant 1 : i64
        sdfg.return %c1_i64 : i64
      }
      sdfg.store %7, %3[] : i64 -> !sdfg.array<i64>
      %8 = sdfg.load %3[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @constant_14{
      %7 = sdfg.tasklet () -> (i16){
        %c0_i16 = arith.constant 0 : i16
        sdfg.return %c0_i16 : i16
      }
      sdfg.store %7, %2[] : i16 -> !sdfg.array<i16>
      %8 = sdfg.load %2[] : !sdfg.array<i16> -> i16
    }
    sdfg.state @constant_16{
      %7 = sdfg.tasklet () -> (i64){
        %c0_i64 = arith.constant 0 : i64
        sdfg.return %c0_i64 : i64
      }
      sdfg.store %7, %1[] : i64 -> !sdfg.array<i64>
      %8 = sdfg.load %1[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @constant_18{
      %7 = sdfg.tasklet () -> (i32){
        %c0_i32 = arith.constant 0 : i32
        sdfg.return %c0_i32 : i32
      }
      sdfg.store %7, %0[] : i32 -> !sdfg.array<i32>
      %8 = sdfg.load %0[] : !sdfg.array<i32> -> i32
    }
    sdfg.state @return_20{
      %7 = sdfg.load %0[] : !sdfg.array<i32> -> i32
      sdfg.store %7, %arg0[] : i32 -> !sdfg.array<i32>
    }
    sdfg.edge {assign = [], condition = "1"} @init_0 -> @external_dce_flag_1_1
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_1_1 -> @alloca_init_3
    sdfg.edge {assign = [], condition = "1"} @alloca_init_3 -> @alloca_init_5
    sdfg.edge {assign = [], condition = "1"} @alloca_init_5 -> @copy_6
    sdfg.edge {assign = [], condition = "1"} @copy_6 -> @alloca_init_8
    sdfg.edge {assign = [], condition = "1"} @alloca_init_8 -> @external_dce_flag_2_9
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_2_9 -> @copy_10
    sdfg.edge {assign = [], condition = "1"} @copy_10 -> @copy_11
    sdfg.edge {assign = [], condition = "1"} @copy_11 -> @constant_12
    sdfg.edge {assign = [], condition = "1"} @constant_12 -> @constant_14
    sdfg.edge {assign = [], condition = "1"} @constant_14 -> @constant_16
    sdfg.edge {assign = [], condition = "1"} @constant_16 -> @constant_18
    sdfg.edge {assign = [], condition = "1"} @constant_18 -> @return_20
  }
}

