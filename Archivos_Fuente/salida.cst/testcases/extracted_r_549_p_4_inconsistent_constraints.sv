class c_549_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_549_4;
    c_549_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0111x01xx01x00xz1z000xx01zx1000xxzxzxxzzzxxxzzxzxxzxzxxxxzzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
