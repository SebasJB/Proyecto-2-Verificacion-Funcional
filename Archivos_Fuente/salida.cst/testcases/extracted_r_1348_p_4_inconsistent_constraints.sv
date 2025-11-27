class c_1348_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1348_4;
    c_1348_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx0z1z0110zx011xx111z1z0zzx01zzxxzxzzzzzzzxzzxxzzxzzxxxzxzzzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
