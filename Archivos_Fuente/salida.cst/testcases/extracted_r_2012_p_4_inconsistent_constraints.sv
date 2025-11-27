class c_2012_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_2012_4;
    c_2012_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx1zz1111zz10z01xx1z1101zx0x11z1xxxzzxzzxxzxzxxzzxzxzxzxzxxzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
