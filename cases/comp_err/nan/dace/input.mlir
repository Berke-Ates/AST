module {
  sdfg.sdfg {entry = @init_0} () -> (%arg0: !sdfg.array<i32>){
    %0 = sdfg.alloc {name = "_constant_tmp_21", transient} () : !sdfg.array<i32>
    %1 = sdfg.alloc {name = "_constant_tmp_19", transient} () : !sdfg.array<f32>
    %2 = sdfg.alloc {name = "_constant_tmp_17", transient} () : !sdfg.array<i1>
    %3 = sdfg.alloc {name = "_constant_tmp_14", transient} () : !sdfg.array<index>
    %4 = sdfg.alloc {name = "_constant_tmp_12", transient} () : !sdfg.array<index>
    %5 = sdfg.alloc {name = "_constant_tmp_10", transient} () : !sdfg.array<f32>
    %6 = sdfg.alloc {name = "_alloca_tmp_6", transient} () : !sdfg.array<1x2xi64>
    %7 = sdfg.alloc {name = "_constant_tmp_5", transient} () : !sdfg.array<f32>
    %8 = sdfg.alloc {name = "_constant_tmp_3", transient} () : !sdfg.array<i64>
    sdfg.state @init_0{
    }
    sdfg.state @external_dce_flag_1_1{
      sdfg.tasklet {insert_code = "external_dce_flag_1"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @constant_2{
      %9 = sdfg.tasklet () -> (i64){
        %c1_i64 = arith.constant 1 : i64
        sdfg.return %c1_i64 : i64
      }
      sdfg.store %9, %8[] : i64 -> !sdfg.array<i64>
      %10 = sdfg.load %8[] : !sdfg.array<i64> -> i64
    }
    sdfg.state @constant_4{
      %9 = sdfg.tasklet () -> (f32){
        %cst = arith.constant -1.41006613 : f32
        sdfg.return %cst : f32
      }
      sdfg.store %9, %7[] : f32 -> !sdfg.array<f32>
      %10 = sdfg.load %7[] : !sdfg.array<f32> -> f32
    }
    sdfg.state @alloca_init_7{
    }
    sdfg.state @external_dce_flag_2_8{
      sdfg.tasklet {insert_code = "external_dce_flag_2"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @constant_9{
      %9 = sdfg.tasklet () -> (f32){
        %cst = arith.constant 0.160039037 : f32
        sdfg.return %cst : f32
      }
      sdfg.store %9, %5[] : f32 -> !sdfg.array<f32>
      %10 = sdfg.load %5[] : !sdfg.array<f32> -> f32
    }
    sdfg.state @constant_11{
      %9 = sdfg.tasklet () -> (index){
        %c0 = arith.constant 0 : index
        sdfg.return %c0 : index
      }
      sdfg.store %9, %4[] : index -> !sdfg.array<index>
      %10 = sdfg.load %4[] : !sdfg.array<index> -> index
    }
    sdfg.state @constant_13{
      %9 = sdfg.tasklet () -> (index){
        %c0 = arith.constant 0 : index
        sdfg.return %c0 : index
      }
      sdfg.store %9, %3[] : index -> !sdfg.array<index>
      %10 = sdfg.load %3[] : !sdfg.array<index> -> index
    }
    sdfg.state @store_15{
      %9 = sdfg.load %8[] : !sdfg.array<i64> -> i64
      %10 = sdfg.load %4[] : !sdfg.array<index> -> index
      %11 = sdfg.load %3[] : !sdfg.array<index> -> index
      sdfg.store %9, %6[%10, %11] : i64 -> !sdfg.array<1x2xi64>
    }
    sdfg.state @constant_16{
      %9 = sdfg.tasklet () -> (i1){
        %false = arith.constant false
        sdfg.return %false : i1
      }
      sdfg.store %9, %2[] : i1 -> !sdfg.array<i1>
      %10 = sdfg.load %2[] : !sdfg.array<i1> -> i1
    }
    sdfg.state @constant_18{
      %9 = sdfg.tasklet () -> (f32){
        %cst = arith.constant 0xFFC00000 : f32
        sdfg.return %cst : f32
      }
      sdfg.store %9, %1[] : f32 -> !sdfg.array<f32>
      %10 = sdfg.load %1[] : !sdfg.array<f32> -> f32
    }
    sdfg.state @constant_20{
      %9 = sdfg.tasklet () -> (i32){
        %c0_i32 = arith.constant 0 : i32
        sdfg.return %c0_i32 : i32
      }
      sdfg.store %9, %0[] : i32 -> !sdfg.array<i32>
      %10 = sdfg.load %0[] : !sdfg.array<i32> -> i32
    }
    sdfg.state @return_22{
      %9 = sdfg.load %0[] : !sdfg.array<i32> -> i32
      sdfg.store %9, %arg0[] : i32 -> !sdfg.array<i32>
    }
    sdfg.edge {assign = [], condition = "1"} @init_0 -> @external_dce_flag_1_1
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_1_1 -> @constant_2
    sdfg.edge {assign = [], condition = "1"} @constant_2 -> @constant_4
    sdfg.edge {assign = [], condition = "1"} @constant_4 -> @alloca_init_7
    sdfg.edge {assign = [], condition = "1"} @alloca_init_7 -> @external_dce_flag_2_8
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_2_8 -> @constant_9
    sdfg.edge {assign = [], condition = "1"} @constant_9 -> @constant_11
    sdfg.edge {assign = [], condition = "1"} @constant_11 -> @constant_13
    sdfg.edge {assign = [], condition = "1"} @constant_13 -> @store_15
    sdfg.edge {assign = [], condition = "1"} @store_15 -> @constant_16
    sdfg.edge {assign = [], condition = "1"} @constant_16 -> @constant_18
    sdfg.edge {assign = [], condition = "1"} @constant_18 -> @constant_20
    sdfg.edge {assign = [], condition = "1"} @constant_20 -> @return_22
  }
}

