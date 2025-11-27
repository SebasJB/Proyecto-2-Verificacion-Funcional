class c_1950_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1950_4;
    c_1950_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1xx01z0x1110101x1zxz1xz1x01010xxxxzzxxxxxxxxxxxxxzxxzzxxxzxxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
