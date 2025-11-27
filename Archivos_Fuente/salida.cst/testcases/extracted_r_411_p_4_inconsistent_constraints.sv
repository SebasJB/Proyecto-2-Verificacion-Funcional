class c_411_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_411_4;
    c_411_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x01z11zz1zzxxzzz11z1xx00x1zx0000zzzxxzzzxxzzzzzxxxzzxzxxzxzxxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
