class c_1974_4;
    bit[31:0] seq_id = 32'ha;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1974_4;
    c_1974_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10zxz0100x01x1xxzxx000110z11x1xzxxzzzzxzxxxzzxzxxxzxzzxzxxzxxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
