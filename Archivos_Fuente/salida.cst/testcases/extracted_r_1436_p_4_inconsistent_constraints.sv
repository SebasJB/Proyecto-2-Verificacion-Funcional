class c_1436_4;
    bit[31:0] seq_id = 32'h6;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1436_4;
    c_1436_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0z1z0zzz00xxzz0x1xzxz011101zzx1xxxzxxzxxzzzxzzxzxzxxzxxzzxzzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
