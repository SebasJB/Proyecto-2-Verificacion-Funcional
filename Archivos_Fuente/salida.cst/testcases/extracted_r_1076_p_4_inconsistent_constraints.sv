class c_1076_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h2;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1076_4;
    c_1076_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1xxz11zx00x0xx0zxzz0xz110z0zxx1zxxzxxzzxzzzxzzxxzzzxzxzzzxxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
