class c_548_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_548_4;
    c_548_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zxxxx1z1xx1z0xxx10z1x1xz1x0xx10zxxzxxxxxxxxzzxxxzzzzxxzxxzxzzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
