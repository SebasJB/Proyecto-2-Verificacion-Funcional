class c_1879_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1879_4;
    c_1879_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z00zzxz0z1x10z000z00z1z1z1zzx0z1xxzxxzzxzxzxzxzzxzzxzzzxzxzzzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
