class c_1469_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h3;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1469_4;
    c_1469_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx1zx0x10z10z000x01x011x11zx01z0xzxxzzzxxxzzzxzxzxzxzzzxxzxxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
