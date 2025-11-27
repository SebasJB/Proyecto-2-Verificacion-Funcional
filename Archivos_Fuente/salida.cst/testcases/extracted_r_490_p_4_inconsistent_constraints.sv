class c_490_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_490_4;
    c_490_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zx1z1x1zz01zzx111z101xxx00010xzxxzxxxxzzxzzzzxzzzzxxxzxzxzzxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
