class c_484_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_484_4;
    c_484_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z11zx00zx0xxz1zx110x0xz111z0xxxxxzxxxzzzxxxzxxzxxxxzxxxzxzzzxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
