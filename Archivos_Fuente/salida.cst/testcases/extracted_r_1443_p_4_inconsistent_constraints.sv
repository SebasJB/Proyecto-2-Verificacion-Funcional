class c_1443_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1443_4;
    c_1443_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz10zz0xx0011z00x1z1x1z0010z10x1xzxxzzxxzzxxxxzxzzzzxxxxzzzxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
