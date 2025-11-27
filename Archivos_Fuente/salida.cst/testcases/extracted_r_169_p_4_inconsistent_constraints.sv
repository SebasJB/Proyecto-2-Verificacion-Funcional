class c_169_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_169_4;
    c_169_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx0x0zzx0xx10x01x1xzx1zx0000xx0zxzzzzxxzxxzxxxzzxxxzxxxzzzzxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
