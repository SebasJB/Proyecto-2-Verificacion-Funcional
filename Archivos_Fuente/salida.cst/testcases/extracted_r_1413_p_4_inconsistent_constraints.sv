class c_1413_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1413_4;
    c_1413_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "11zxxxx1zzxxzz10z1x1100z0x0zzxz1zzzzxxxxzxxzzxxxxxxxxzxxzzzxxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
