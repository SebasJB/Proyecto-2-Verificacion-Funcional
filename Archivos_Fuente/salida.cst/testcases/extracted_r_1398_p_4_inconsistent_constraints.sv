class c_1398_4;
    bit[31:0] seq_id = 32'h0;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1398_4;
    c_1398_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1xz0z1xx0100100x01z0010z11z101xzxzxxzxzxzxxzzxxxxzzxxzxzxxzxxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
