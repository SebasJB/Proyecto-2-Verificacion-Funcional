class c_974_4;
    bit[31:0] seq_id = 32'h3;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_974_4;
    c_974_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "01z0101x00011x0zxx1zx01xx10xxxx1xzzzzzxxzzzzzxzzxzxzzzxzzzzxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
