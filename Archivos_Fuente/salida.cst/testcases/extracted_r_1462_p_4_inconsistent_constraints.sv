class c_1462_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_1462_4;
    c_1462_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x11x10x10x0x11xx0xx11xx1x0zxx1z0zxzzxzzxxxxzxxxxxxxzxzxzxxxzxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
