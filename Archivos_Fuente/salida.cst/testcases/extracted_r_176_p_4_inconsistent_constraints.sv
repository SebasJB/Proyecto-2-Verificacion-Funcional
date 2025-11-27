class c_176_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_176_4;
    c_176_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z11x0x1xz1z0101zxx0010xxxx111z0zxzxxxzxxzxxxxzzxxzxxxxzxzzzxxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
