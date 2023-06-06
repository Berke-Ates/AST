module {
  sdfg.sdfg {entry = @init_0} () -> (%arg0: !sdfg.array<i32>){
    %0 = sdfg.alloc {name = "_load_tmp_16", transient} () : !sdfg.array<f64>
    %1 = sdfg.alloc {name = "_alloc_tmp_14", transient} () : !sdfg.array<1x100000x100000xf64>
    %2 = sdfg.alloc {name = "_constant_tmp_12", transient} () : !sdfg.array<index>
    %3 = sdfg.alloc {name = "_constant_tmp_10", transient} () : !sdfg.array<index>
    %4 = sdfg.alloc {name = "_constant_tmp_8", transient} () : !sdfg.array<index>
    %5 = sdfg.alloc {name = "_constant_tmp_6", transient} () : !sdfg.array<index>
    %6 = sdfg.alloc {name = "_constant_tmp_4", transient} () : !sdfg.array<index>
    %7 = sdfg.alloc {name = "_constant_tmp_2", transient} () : !sdfg.array<i32>
    sdfg.state @init_0{
    }
    sdfg.state @constant_1{
      %8 = sdfg.tasklet () -> (i32){
        %c23252_i32 = arith.constant 23252 : i32
        sdfg.return %c23252_i32 : i32
      }
      sdfg.store %8, %7[] : i32 -> !sdfg.array<i32>
      %9 = sdfg.load %7[] : !sdfg.array<i32> -> i32
    }
    sdfg.state @constant_3{
      %8 = sdfg.tasklet () -> (index){
        %c94387 = arith.constant 94387 : index
        sdfg.return %c94387 : index
      }
      sdfg.store %8, %6[] : index -> !sdfg.array<index>
      %9 = sdfg.load %6[] : !sdfg.array<index> -> index
    }
    sdfg.state @constant_5{
      %8 = sdfg.tasklet () -> (index){
        %c10348 = arith.constant 10348 : index
        sdfg.return %c10348 : index
      }
      sdfg.store %8, %5[] : index -> !sdfg.array<index>
      %9 = sdfg.load %5[] : !sdfg.array<index> -> index
    }
    sdfg.state @constant_7{
      %8 = sdfg.tasklet () -> (index){
        %c39434 = arith.constant 39434 : index
        sdfg.return %c39434 : index
      }
      sdfg.store %8, %4[] : index -> !sdfg.array<index>
      %9 = sdfg.load %4[] : !sdfg.array<index> -> index
    }
    sdfg.state @constant_9{
      %8 = sdfg.tasklet () -> (index){
        %c23252 = arith.constant 23252 : index
        sdfg.return %c23252 : index
      }
      sdfg.store %8, %3[] : index -> !sdfg.array<index>
      %9 = sdfg.load %3[] : !sdfg.array<index> -> index
    }
    sdfg.state @constant_11{
      %8 = sdfg.tasklet () -> (index){
        %c0 = arith.constant 0 : index
        sdfg.return %c0 : index
      }
      sdfg.store %8, %2[] : index -> !sdfg.array<index>
      %9 = sdfg.load %2[] : !sdfg.array<index> -> index
    }
    sdfg.state @external_dce_flag_1_13{
      sdfg.tasklet {insert_code = "external_dce_flag_1"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @alloc_init_15{
    }
    sdfg.state @load_17{
      %8 = sdfg.load %2[] : !sdfg.array<index> -> index
      %9 = sdfg.load %3[] : !sdfg.array<index> -> index
      %10 = sdfg.load %4[] : !sdfg.array<index> -> index
      %11 = sdfg.load %1[%8, %9, %10] : !sdfg.array<1x100000x100000xf64> -> f64
      sdfg.store %11, %0[] : f64 -> !sdfg.array<f64>
      %12 = sdfg.load %0[] : !sdfg.array<f64> -> f64
    }
    sdfg.state @store_18{
      %8 = sdfg.load %0[] : !sdfg.array<f64> -> f64
      %9 = sdfg.load %2[] : !sdfg.array<index> -> index
      %10 = sdfg.load %5[] : !sdfg.array<index> -> index
      %11 = sdfg.load %6[] : !sdfg.array<index> -> index
      sdfg.store %8, %1[%9, %10, %11] : f64 -> !sdfg.array<1x100000x100000xf64>
    }
    sdfg.state @return_19{
      %8 = sdfg.load %7[] : !sdfg.array<i32> -> i32
      sdfg.store %8, %arg0[] : i32 -> !sdfg.array<i32>
    }
    sdfg.edge {assign = [], condition = "1"} @init_0 -> @constant_1
    sdfg.edge {assign = [], condition = "1"} @constant_1 -> @constant_3
    sdfg.edge {assign = [], condition = "1"} @constant_3 -> @constant_5
    sdfg.edge {assign = [], condition = "1"} @constant_5 -> @constant_7
    sdfg.edge {assign = [], condition = "1"} @constant_7 -> @constant_9
    sdfg.edge {assign = [], condition = "1"} @constant_9 -> @constant_11
    sdfg.edge {assign = [], condition = "1"} @constant_11 -> @external_dce_flag_1_13
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_1_13 -> @alloc_init_15
    sdfg.edge {assign = [], condition = "1"} @alloc_init_15 -> @load_17
    sdfg.edge {assign = [], condition = "1"} @load_17 -> @store_18
    sdfg.edge {assign = [], condition = "1"} @store_18 -> @return_19
  }
}

