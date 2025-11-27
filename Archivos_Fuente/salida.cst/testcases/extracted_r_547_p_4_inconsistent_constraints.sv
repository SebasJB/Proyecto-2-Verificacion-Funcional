class c_547_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_547_4;
    c_547_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0z1xx000x11xxx0x0xxx1zz01zz100zzxzzzxxzxzzzxzzzzxzxzzzxzzzzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
