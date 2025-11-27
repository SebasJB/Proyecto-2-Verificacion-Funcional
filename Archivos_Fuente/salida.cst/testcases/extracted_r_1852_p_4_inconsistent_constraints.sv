class c_1852_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1852_4;
    c_1852_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zxzxz01zz0z01z000z0zz001z0110zx1zzzzxxxzxzzxzxxxxzxzxxzzxxzxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
