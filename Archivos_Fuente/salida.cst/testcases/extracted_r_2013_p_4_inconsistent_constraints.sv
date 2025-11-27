class c_2013_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_2013_4;
    c_2013_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx01xxxz0x111xx0100z0z10zzzz11z0zzxzzxxzzzxxxzxzxzzxxzxxxxxzxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
