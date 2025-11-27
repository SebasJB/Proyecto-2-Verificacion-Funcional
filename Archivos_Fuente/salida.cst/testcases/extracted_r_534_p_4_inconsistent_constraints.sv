class c_534_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h2;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_534_4;
    c_534_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1z1xx01xz1zxz110z1z11zx1xx1001x1xzxxzzzxzxzxzzxxxxxzzzxzxzzxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
