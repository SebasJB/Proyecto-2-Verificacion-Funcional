class c_1856_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1856_4;
    c_1856_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x0xzxzz1x0x110z110x0xz0z0zx1xxzxzxxxxzxxxxzxxzxxxzxzxzzxxxxxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
