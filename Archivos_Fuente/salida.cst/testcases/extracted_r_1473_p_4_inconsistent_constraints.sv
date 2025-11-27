class c_1473_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_1473_4;
    c_1473_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1xzzzz011x0x10010x0001110x0z0xz0xxzzzxzzxxxzzxxzzxxxzzzzzzxzxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
