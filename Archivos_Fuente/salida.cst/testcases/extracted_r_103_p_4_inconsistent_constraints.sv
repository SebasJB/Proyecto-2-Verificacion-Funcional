class c_103_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_103_4;
    c_103_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0zxz0xxx00xz1zx1x1xxz100z1x011xxzxzxzxzzxxzxxzzxzxxzzzxzzxzzxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
