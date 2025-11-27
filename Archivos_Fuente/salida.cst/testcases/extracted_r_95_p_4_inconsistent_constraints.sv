class c_95_4;
    bit[31:0] seq_id = 32'h1;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_95_4;
    c_95_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z11xx0x1z01z1z11x1x00z0xxxx0xzxzzzxxzzxzxxzxzzxzzxxzxxxxxxxzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
