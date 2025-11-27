class c_2023_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_2023_4;
    c_2023_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "01110z000101zx01zxz100zx0z0x0x0xzzzzzzzzzzxxzzzzxzxzzzxzxzzxxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
