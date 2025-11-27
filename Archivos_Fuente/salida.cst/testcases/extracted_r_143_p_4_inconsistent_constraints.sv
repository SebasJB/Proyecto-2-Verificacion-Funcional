class c_143_4;
    bit[31:0] seq_id = 32'h8;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_143_4;
    c_143_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "100x0z1x0zz01000xxx01x0z101xxxxzzxxzxxxxzxzxxxxxzxxzzxzzxzzxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
