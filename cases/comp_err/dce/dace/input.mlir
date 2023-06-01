module {
  sdfg.sdfg {entry = @init_0} () -> (%arg0: !sdfg.array<i32>){
    %0 = sdfg.alloc {name = "_constant_tmp_21", transient} () : !sdfg.array<i32>
    %1 = sdfg.alloc {name = "_constant_tmp_19", transient} () : !sdfg.array<f16>
    %2 = sdfg.alloc {name = "_divsi_tmp_17", transient} () : !sdfg.array<i64>
    %3 = sdfg.alloc {name = "_maxsi_tmp_15", transient} () : !sdfg.array<i64>
    %4 = sdfg.alloc {name = "_constant_tmp_13", transient} () : !sdfg.array<i64>
    %5 = sdfg.alloc {name = "_load_tmp_10", transient} () : !sdfg.array<i64>
    %6 = sdfg.alloc {name = "_constant_tmp_9", transient} () : !sdfg.array<index>
    %7 = sdfg.alloc {name = "_constant_tmp_7", transient} () : !sdfg.array<index>
    %8 = sdfg.alloc {name = "_alloc_tmp_2", transient} () : !sdfg.array<sym("s_1")x1xi64>
    sdfg.state @init_0{
    }
    sdfg.state @alloc_init_3{
    }
    sdfg.state @copy_4{
      sdfg.copy %8 -> %8 : !sdfg.array<sym("s_1")x1xi64>
    }
    sdfg.state @external_dce_flag_1_5{
      sdfg.tasklet {insert_code = "external_dce_flag_1"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @constant_6{
      %9 = sdfg.tasklet () -> (index){
        %c0 = arith.constant 0 : index
        sdfg.return %c0 : index
      }
      sdfg.store %9, %7[] : index -> !sdfg.array<index>
      %10 = sdfg.load %7[] : !sdfg.array<index> -> index
    }
    sdfg.state @constant_8{
      %9 = sdfg.tasklet () -> (index){
        %c0 = arith.constant 0 : index
        sdfg.return %c0 : index
      }
      sdfg.store %9, %6[] : index -> !sdfg.array<index>
      %10 = sdfg.load %6[] : !sdfg.array<index> -> index
    }
    sdfg.state @load_11{
      %9 = sdfg.load %7[] : !sdfg.array<index> -> index
      %10 = sdfg.load %6[] : !sdfg.array<index> -> index
      %11 = sdfg.load %8[%9, %10] : !sdfg.array<sym("s_1")x1xi64> -> i64
      sdfg.store %11, %5[] : i64 -> !sdfg.array<i64>
      %12 = sdfg.load %5[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @constant_12{
      %9 = sdfg.tasklet () -> (i64){
        %c1_i64 = arith.constant 1 : i64
        sdfg.return %c1_i64 : i64
      }
      sdfg.store %9, %4[] : i64 -> !sdfg.array<i64>
      %10 = sdfg.load %4[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @maxsi_14{
      %9 = sdfg.load %5[] : !sdfg.array<i64> -> i64
      %10 = sdfg.load %4[] : !sdfg.array<i64> -> i64
      %11 = sdfg.tasklet (%9 as %arg1: i64, %10 as %arg2: i64) -> (i64){
        %13 = arith.maxsi %arg1, %arg2 : i64
        sdfg.return %13 : i64
      }
      sdfg.store %11, %3[] : i64 -> !sdfg.array<i64>
      %12 = sdfg.load %3[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @divsi_16{
      %9 = sdfg.load %5[] : !sdfg.array<i64> -> i64
      %10 = sdfg.load %3[] : !sdfg.array<i64> -> i64
      %11 = sdfg.tasklet (%9 as %arg1: i64, %10 as %arg2: i64) -> (i64){
        %13 = arith.divsi %arg1, %arg2 : i64
        sdfg.return %13 : i64
      }
      sdfg.store %11, %2[] : i64 -> !sdfg.array<i64>
      %12 = sdfg.load %2[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @constant_18{
      %9 = sdfg.tasklet () -> (f16){
        %cst = arith.constant -5.844730e-01 : f16
        sdfg.return %cst : f16
      }
      sdfg.store %9, %1[] : f16 -> !sdfg.array<f16>
      %10 = sdfg.load %1[] : !sdfg.array<f16> -> f16
    }
    sdfg.state @constant_20{
      %9 = sdfg.tasklet () -> (i32){
        %c2_i32 = arith.constant 2 : i32
        sdfg.return %c2_i32 : i32
      }
      sdfg.store %9, %0[] : i32 -> !sdfg.array<i32>
      %10 = sdfg.load %0[] : !sdfg.array<i32> -> i32
    }
    sdfg.state @return_22{
      %9 = sdfg.load %0[] : !sdfg.array<i32> -> i32
      sdfg.store %9, %arg0[] : i32 -> !sdfg.array<i32>
    }
    sdfg.edge {assign = [], condition = "1"} @init_0 -> @alloc_init_3
    sdfg.edge {assign = [], condition = "1"} @alloc_init_3 -> @copy_4
    sdfg.edge {assign = [], condition = "1"} @copy_4 -> @external_dce_flag_1_5
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_1_5 -> @constant_6
    sdfg.edge {assign = [], condition = "1"} @constant_6 -> @constant_8
    sdfg.edge {assign = [], condition = "1"} @constant_8 -> @load_11
    sdfg.edge {assign = [], condition = "1"} @load_11 -> @constant_12
    sdfg.edge {assign = [], condition = "1"} @constant_12 -> @maxsi_14
    sdfg.edge {assign = [], condition = "1"} @maxsi_14 -> @divsi_16
    sdfg.edge {assign = [], condition = "1"} @divsi_16 -> @constant_18
    sdfg.edge {assign = [], condition = "1"} @constant_18 -> @constant_20
    sdfg.edge {assign = [], condition = "1"} @constant_20 -> @return_22
  }
}

