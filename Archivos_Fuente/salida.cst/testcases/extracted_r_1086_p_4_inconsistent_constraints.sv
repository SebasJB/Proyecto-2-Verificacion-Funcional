class c_1086_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_1086_4;
    c_1086_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xxzx1zz1z0xz1xx1z1zz00xx0010xz00zxxxxzzzxxxzzxzzzxxxzzxxzxzzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
