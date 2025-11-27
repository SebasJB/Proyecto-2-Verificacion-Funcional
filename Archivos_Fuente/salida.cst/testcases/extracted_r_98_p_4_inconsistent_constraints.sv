class c_98_4;
    bit[31:0] seq_id = 32'h1;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_98_4;
    c_98_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "01z01z0001zzz001x001x0z0xx1xxzx1xzzzxxxzzxzxzxxzxzzxzzxzzxzzzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
