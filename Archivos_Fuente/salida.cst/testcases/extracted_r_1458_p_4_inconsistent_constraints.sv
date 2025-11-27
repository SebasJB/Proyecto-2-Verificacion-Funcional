class c_1458_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h3;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1458_4;
    c_1458_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "111x1x00xz0xxz0x1zx0111x1x11z0z1xzzxxxxzzzxzzzxxxxzzzzzxxxxzxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
