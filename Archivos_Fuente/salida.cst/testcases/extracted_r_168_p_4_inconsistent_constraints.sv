class c_168_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_168_4;
    c_168_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1z101zz10x0xz1xzz0z0010x0xz000xzxzzxxzzzxxxxxxxxxxzxzzzxxxxxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
