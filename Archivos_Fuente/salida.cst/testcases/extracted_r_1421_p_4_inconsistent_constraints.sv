class c_1421_4;
    bit[31:0] seq_id = 32'h8;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1421_4;
    c_1421_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0z11xx010zx0xz1xx10x01xz101zzx1zxzzzxzzzzxxzzxzzxzzxzzzzzzxxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
