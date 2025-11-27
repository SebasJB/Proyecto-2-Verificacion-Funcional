class c_161_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_161_4;
    c_161_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "11x1x1zxx01z0x11z111zz0010x0101zxzzxxxxxxzzzzzxxxzzxxzxzzxzzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
