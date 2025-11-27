class c_86_4;
    bit[31:0] seq_id = 32'h4;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_86_4;
    c_86_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0x00zxz11x010000z01zx1zz01zzxx0xxxxxzxzxxxzxzzxxxxzzxxxxzzxzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
