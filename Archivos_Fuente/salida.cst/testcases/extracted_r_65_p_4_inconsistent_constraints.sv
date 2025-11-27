class c_65_4;
    bit[31:0] seq_id = 32'h0;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_65_4;
    c_65_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx01z0x01xx1101zx110xx1xzxx00zzxxxzzzxxzzxzxzzzzzxxzxxxxzzzxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
