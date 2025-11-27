class c_36_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_36_4;
    c_36_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0x1x1x0x01zz1zx00x1z00z0x10zxx1zzxzzxxzxzzxxxzzxxxxzzzxxxzxxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
