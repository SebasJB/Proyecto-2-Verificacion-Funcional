class c_1095_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_1095_4;
    c_1095_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10zzxx10101xzxx11x0z00zxx1xz0x00zzxzxxzxxxxxxzxzzxzxzxzzzxxxxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
