class c_132_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_132_4;
    c_132_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0z00z000z0xz0z11xz0x0z0z1x0110x1xxxzxxxzxxzzxzzzxzzzzxxxxzzzzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
