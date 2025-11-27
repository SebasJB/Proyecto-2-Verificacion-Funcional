class c_2901_2;
    bit[4:0] src_id = 5'h5;
    integer test_mode = 2; // ( test_mode = $unit::scenario_t::COLLISION ) 
    rand bit[31:0] dest_addr; // rand_mode = ON 

    constraint c_dest_addr_this    // (constraint_mode = ON) (TypesandTransactions.sv:120)
    {
       (dest_addr != src_id);
       (((!(test_mode == 0 /* $unit::scenario_t::GENERAL */)) && (!(test_mode == 1 /* $unit::scenario_t::SATURATION */))) && (test_mode == 2 /* $unit::scenario_t::COLLISION */)) -> (dest_addr == 5);
    }
endclass

program p_2901_2;
    c_2901_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z10xzz11zzz01xxxz0x100x00z0zz1z1xzxzzzzxxxzzxzzzxzzzxxxzxzzxzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
