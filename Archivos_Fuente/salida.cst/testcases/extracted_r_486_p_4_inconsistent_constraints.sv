class c_486_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_486_4;
    c_486_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10z0z10xx10xzxxz01100xxz1z0x1z11zzxxzzxxxzxxxxzxxxzzzxxzxzzxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
