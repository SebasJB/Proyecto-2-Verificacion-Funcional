class c_2014_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_2014_4;
    c_2014_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0xx00zx0x1000zz11x001111zz1x0zz0xzxzxzzzzzzxxzxxxzzxzzxxxxxxzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
