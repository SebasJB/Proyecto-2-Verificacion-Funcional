class c_1391_4;
    bit[31:0] seq_id = 32'h6;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1391_4;
    c_1391_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xz0x0xz0xz10x1z101zx1110zxz10zxxxzxxxzxzzxxxxzzxxxzxzzxzzxxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
