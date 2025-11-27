class c_1344_4;
    bit[31:0] seq_id = 32'ha;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1344_4;
    c_1344_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10z0xzx01z010000zzzz010z0z1zxxz1zzzzxxzxxzxzzxxxxzzxzzxzzxxxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
