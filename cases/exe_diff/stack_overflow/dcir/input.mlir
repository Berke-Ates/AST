module {
  sdfg.sdfg {entry = @init_0} () -> (%arg0: !sdfg.array<i32>){
    %0 = sdfg.alloc {name = "_constant_tmp_2", transient} () : !sdfg.array<i32>
    sdfg.state @init_0{
    }
    sdfg.state @constant_1{
      %1 = sdfg.tasklet () -> (i32){
        %c0_i32 = arith.constant 0 : i32
        sdfg.return %c0_i32 : i32
      }
      sdfg.store %1, %0[] : i32 -> !sdfg.array<i32>
      %2 = sdfg.load %0[] : !sdfg.array<i32> -> i32
    }
    sdfg.state @external_dce_flag_1_3{
      sdfg.tasklet {insert_code = "external_dce_flag_1"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @external_dce_flag_2_4{
      sdfg.tasklet {insert_code = "external_dce_flag_2"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @external_dce_flag_3_5{
      sdfg.tasklet {insert_code = "external_dce_flag_3"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @external_dce_flag_4_6{
      sdfg.tasklet {insert_code = "external_dce_flag_4"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @external_dce_flag_5_7{
      sdfg.tasklet {insert_code = "external_dce_flag_5"} () -> (){
        sdfg.return
      }
    }
    sdfg.state @return_8{
      %1 = sdfg.load %0[] : !sdfg.array<i32> -> i32
      sdfg.store %1, %arg0[] : i32 -> !sdfg.array<i32>
    }
    sdfg.edge {assign = [], condition = "1"} @init_0 -> @constant_1
    sdfg.edge {assign = [], condition = "1"} @constant_1 -> @external_dce_flag_1_3
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_1_3 -> @external_dce_flag_2_4
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_2_4 -> @external_dce_flag_3_5
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_3_5 -> @external_dce_flag_4_6
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_4_6 -> @external_dce_flag_5_7
    sdfg.edge {assign = [], condition = "1"} @external_dce_flag_5_7 -> @return_8
  }
}

