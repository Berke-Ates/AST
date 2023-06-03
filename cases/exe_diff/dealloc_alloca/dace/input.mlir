module {
  sdfg.sdfg {entry = @init_0} () -> (%arg0: !sdfg.array<i32>){
    %0 = sdfg.alloc {name = "_constant_tmp_5", transient} () : !sdfg.array<i32>
    %1 = sdfg.alloc {name = "_alloca_tmp_1", transient} () : !sdfg.array<100000xi64>
    sdfg.state @init_0{
    }
    sdfg.state @alloca_init_2{
    }
    sdfg.state @external_dce_flag_1_3{
      sdfg.tasklet {insert_code = "external_dce_flag_1"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @constant_4{
      %2 = sdfg.tasklet () -> (i32){
        %c0_i32 = arith.constant 0 : i32
        sdfg.return %c0_i32 : i32
      }
      sdfg.store %2, %0[] : i32 -> !sdfg.array<i32>
      %3 = sdfg.load %0[] : !sdfg.array<i32> -> i32
    }
    sdfg.state @return_6{
      %2 = sdfg.load %0[] : !sdfg.array<i32> -> i32
      sdfg.store %2, %arg0[] : i32 -> !sdfg.array<i32>
    }
    sdfg.edge {assign = [], condition = "1"} @init_0 -> @alloca_init_2
    sdfg.edge {assign = [], condition = "1"} @alloca_init_2 -> @external_dce_flag_1_3
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_1_3 -> @constant_4
    sdfg.edge {assign = [], condition = "1"} @constant_4 -> @return_6
  }
}

