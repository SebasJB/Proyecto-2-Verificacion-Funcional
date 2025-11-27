class c_1053_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1053_4;
    c_1053_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10x001xz0z1z1x1x1z0z000x0xzx0z00xxzxzzxxxzxzxzzxzzxzzzxzxxzzxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
