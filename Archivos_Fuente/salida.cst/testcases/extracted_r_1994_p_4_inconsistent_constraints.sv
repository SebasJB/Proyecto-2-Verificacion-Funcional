class c_1994_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1994_4;
    c_1994_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x10x1x1110100xzz1x1xxz1x10xzx0z0xxzxzzzzzxxxxxzxzxzzzzxzzxxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
