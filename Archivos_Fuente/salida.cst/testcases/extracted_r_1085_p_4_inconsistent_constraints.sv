class c_1085_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_1085_4;
    c_1085_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "101zxz1x11xzxz0zz1z0z0110xz1z0z0zzzzzzxxxxzzxzxzzzzxxxxzzxzxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
