class c_939_4;
    bit[31:0] seq_id = 32'h6;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_939_4;
    c_939_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0xxz1zxxzx011zx0000zz1xz0z1xzz0zzxzzxxxzzzxxxxxxxzxzzxzzxxzxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
