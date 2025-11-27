class c_537_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_537_4;
    c_537_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00x1zxzx10z1x1zx1xxxx0z0x0x0011xzzxzzzzxxxxxxzzxxxxxzxzxxxxxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
