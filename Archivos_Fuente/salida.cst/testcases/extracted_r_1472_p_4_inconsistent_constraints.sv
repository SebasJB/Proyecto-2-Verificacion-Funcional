class c_1472_4;
    integer test_mode = 0; // ( test_mode = $unit::scenario_t::GENERAL ) 

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (test_mode == 1 /* $unit::scenario_t::SATURATION */);
    }
endclass

program p_1472_4;
    c_1472_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "110xx1100zxz11011z01x0zxzx1xzzxxzxzzxzzzxxxxzzzxxxxxzxxxzzzzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
