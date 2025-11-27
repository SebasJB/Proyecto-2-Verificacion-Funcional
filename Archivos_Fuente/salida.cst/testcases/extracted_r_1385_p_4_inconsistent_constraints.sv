class c_1385_4;
    bit[31:0] seq_id = 32'hc;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1385_4;
    c_1385_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x011zx00z1xzxxz1xzz011z0z0z1xzzzxxxxxxzzzxxzxzxxxxxzzzxzzzxzxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
