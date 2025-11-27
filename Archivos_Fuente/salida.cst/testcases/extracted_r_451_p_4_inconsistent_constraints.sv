class c_451_4;
    bit[31:0] seq_id = 32'ha;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_451_4;
    c_451_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx1010zzxzz1z0z1x1z001z10z100zxzxxxxxzzxxxzxzzzzzxxxxxzxxzzxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
