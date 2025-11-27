class c_1938_4;
    bit[31:0] seq_id = 32'h6;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1938_4;
    c_1938_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x00xzx10zxzxxzxzzxxxz1z11z1xx1x0xzxxxzxxzxxzzzxxxxzzzxzzzzxxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
