class c_452_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_452_4;
    c_452_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00zxx01x01zzx10z100x011x1zx1011xzzzxxzxzzxxxxzzzxzzxzxzzzzzzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
