class c_1480_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_1480_4;
    c_1480_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz0zz0x00xz0zx0zxx1zzx1111xx11x1xxxzxzzzxzzxzxxxzzxxxxxzzzzzxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
