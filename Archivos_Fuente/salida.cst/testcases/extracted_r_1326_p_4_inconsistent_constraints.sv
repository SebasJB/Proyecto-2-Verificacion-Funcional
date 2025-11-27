class c_1326_4;
    bit[31:0] seq_id = 32'h7;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1326_4;
    c_1326_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x001xxz01z1z1000z01zx0xxzz1z1100xzxxxzxzzzxzxxxzxxxzxzzxxzxxxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
