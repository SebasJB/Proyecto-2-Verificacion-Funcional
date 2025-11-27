class c_538_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_538_4;
    c_538_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx1z10010zx11x0x01x11xxz1z00zx1zzzxxzxzxzxxzzzxzzzxzzzxxxxzxxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
