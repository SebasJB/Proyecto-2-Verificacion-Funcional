class c_1383_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1383_4;
    c_1383_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z000x1x0zxxx10x0xzxx1zzx11x11x1xxzzzxxxzzxxzxxxxzxzzzxxzzxzxxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
