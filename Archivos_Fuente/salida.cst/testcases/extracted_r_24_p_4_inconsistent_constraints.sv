class c_24_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_24_4;
    c_24_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "001x1z1zzz01xz0xzz0zx1z1x0x10101zxzzzzxxzzxxzzxxzxzzxxzzxxxxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
