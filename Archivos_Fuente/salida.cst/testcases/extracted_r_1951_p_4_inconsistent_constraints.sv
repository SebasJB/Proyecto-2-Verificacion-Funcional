class c_1951_4;
    bit[31:0] seq_id = 32'hc;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1951_4;
    c_1951_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0z01x1x10z0xxz100xz0z0x00x1xxx1zzxzzxzzzzxxxzxxxzxzxzxxzzzxzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
