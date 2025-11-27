class c_162_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_162_4;
    c_162_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "11xxxzz0xz1zx0x1z01z1xz01z0x1x00zxxxzxzzxxzxxzxzxxzzzzxxzzxzxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
