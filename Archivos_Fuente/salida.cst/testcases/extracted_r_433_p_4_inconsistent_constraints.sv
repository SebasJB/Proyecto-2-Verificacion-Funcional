class c_433_4;
    bit[31:0] seq_id = 32'h7;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_433_4;
    c_433_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xzzzx1xxzx11001xzz0x1x11zx1z01zzzxzxzxxxxxxzxxzzxzzxxxzzzzxxxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
