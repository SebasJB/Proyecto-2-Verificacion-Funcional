class c_555_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_555_4;
    c_555_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zz111x1111z11z000x0z10z11x001zxxzxxxzxzxxxzxzxzzxxzzzxxzxzzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
