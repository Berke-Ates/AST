module {
  sdfg.sdfg {entry = @init_0} () -> (%arg0: !sdfg.array<i32>){
    %0 = sdfg.alloc {name = "_constant_tmp_20", transient} () : !sdfg.array<i32>
    %1 = sdfg.alloc {name = "_constant_tmp_17", transient} () : !sdfg.array<index>
    %2 = sdfg.alloc {name = "_constant_tmp_15", transient} () : !sdfg.array<index>
    %3 = sdfg.alloc {name = "_constant_tmp_13", transient} () : !sdfg.array<index>
    %4 = sdfg.alloc {name = "_load_tmp_10", transient} () : !sdfg.array<f64>
    %5 = sdfg.alloc {name = "_constant_tmp_9", transient} () : !sdfg.array<index>
    %6 = sdfg.alloc {name = "_constant_tmp_7", transient} () : !sdfg.array<index>
    %7 = sdfg.alloc {name = "_constant_tmp_5", transient} () : !sdfg.array<index>
    %8 = sdfg.alloc {name = "_alloc_tmp_2", transient} () : !sdfg.array<1x100000x100000xf64>
    sdfg.state @init_0{
    }
    sdfg.state @external_dce_flag_1_1{
      sdfg.tasklet {insert_code = "external_dce_flag_1"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @alloc_init_3{
    }
    sdfg.state @constant_4{
      %9 = sdfg.tasklet () -> (index){
        %c0 = arith.constant 0 : index
        sdfg.return %c0 : index
      }
      sdfg.store %9, %7[] : index -> !sdfg.array<index>
      %10 = sdfg.load %7[] : !sdfg.array<index> -> index
    }
    sdfg.state @constant_6{
      %9 = sdfg.tasklet () -> (index){
        %c23252 = arith.constant 23252 : index
        sdfg.return %c23252 : index
      }
      sdfg.store %9, %6[] : index -> !sdfg.array<index>
      %10 = sdfg.load %6[] : !sdfg.array<index> -> index
    }
    sdfg.state @constant_8{
      %9 = sdfg.tasklet () -> (index){
        %c39434 = arith.constant 39434 : index
        sdfg.return %c39434 : index
      }
      sdfg.store %9, %5[] : index -> !sdfg.array<index>
      %10 = sdfg.load %5[] : !sdfg.array<index> -> index
    }
    sdfg.state @load_11{
      %9 = sdfg.load %7[] : !sdfg.array<index> -> index
      %10 = sdfg.load %6[] : !sdfg.array<index> -> index
      %11 = sdfg.load %5[] : !sdfg.array<index> -> index
      %12 = sdfg.load %8[%9, %10, %11] : !sdfg.array<1x100000x100000xf64> -> f64
      sdfg.store %12, %4[] : f64 -> !sdfg.array<f64>
      %13 = sdfg.load %4[] : !sdfg.array<f64> -> f64
    }
    sdfg.state @constant_12{
      %9 = sdfg.tasklet () -> (index){
        %c0 = arith.constant 0 : index
        sdfg.return %c0 : index
      }
      sdfg.store %9, %3[] : index -> !sdfg.array<index>
      %10 = sdfg.load %3[] : !sdfg.array<index> -> index
    }
    sdfg.state @constant_14{
      %9 = sdfg.tasklet () -> (index){
        %c10348 = arith.constant 10348 : index
        sdfg.return %c10348 : index
      }
      sdfg.store %9, %2[] : index -> !sdfg.array<index>
      %10 = sdfg.load %2[] : !sdfg.array<index> -> index
    }
    sdfg.state @constant_16{
      %9 = sdfg.tasklet () -> (index){
        %c94387 = arith.constant 94387 : index
        sdfg.return %c94387 : index
      }
      sdfg.store %9, %1[] : index -> !sdfg.array<index>
      %10 = sdfg.load %1[] : !sdfg.array<index> -> index
    }
    sdfg.state @store_18{
      %9 = sdfg.load %4[] : !sdfg.array<f64> -> f64
      %10 = sdfg.load %3[] : !sdfg.array<index> -> index
      %11 = sdfg.load %2[] : !sdfg.array<index> -> index
      %12 = sdfg.load %1[] : !sdfg.array<index> -> index
      sdfg.store %9, %8[%10, %11, %12] : f64 -> !sdfg.array<1x100000x100000xf64>
    }
    sdfg.state @constant_19{
      %9 = sdfg.tasklet () -> (i32){
        %c23252_i32 = arith.constant 23252 : i32
        sdfg.return %c23252_i32 : i32
      }
      sdfg.store %9, %0[] : i32 -> !sdfg.array<i32>
      %10 = sdfg.load %0[] : !sdfg.array<i32> -> i32
    }
    sdfg.state @return_21{
      %9 = sdfg.load %0[] : !sdfg.array<i32> -> i32
      sdfg.store %9, %arg0[] : i32 -> !sdfg.array<i32>
    }
    sdfg.edge {assign = [], condition = "1"} @init_0 -> @external_dce_flag_1_1
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_1_1 -> @alloc_init_3
    sdfg.edge {assign = [], condition = "1"} @alloc_init_3 -> @constant_4
    sdfg.edge {assign = [], condition = "1"} @constant_4 -> @constant_6
    sdfg.edge {assign = [], condition = "1"} @constant_6 -> @constant_8
    sdfg.edge {assign = [], condition = "1"} @constant_8 -> @load_11
    sdfg.edge {assign = [], condition = "1"} @load_11 -> @constant_12
    sdfg.edge {assign = [], condition = "1"} @constant_12 -> @constant_14
    sdfg.edge {assign = [], condition = "1"} @constant_14 -> @constant_16
    sdfg.edge {assign = [], condition = "1"} @constant_16 -> @store_18
    sdfg.edge {assign = [], condition = "1"} @store_18 -> @constant_19
    sdfg.edge {assign = [], condition = "1"} @constant_19 -> @return_21
  }
}

