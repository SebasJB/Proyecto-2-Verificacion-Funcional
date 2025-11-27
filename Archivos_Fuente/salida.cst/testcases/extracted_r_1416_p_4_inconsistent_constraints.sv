class c_1416_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1416_4;
    c_1416_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zzx0x0011xzz11100x1110xx11x0xx1zzxxxxxzxxzzzxxxzzxzzzxzzzxzzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
