class c_467_4;
    bit[31:0] seq_id = 32'h5;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_467_4;
    c_467_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10x01z0x111zx0z11x000xx1z000101xxxzzzxxxzxzxxxxxzxxxzxzzzzxxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
