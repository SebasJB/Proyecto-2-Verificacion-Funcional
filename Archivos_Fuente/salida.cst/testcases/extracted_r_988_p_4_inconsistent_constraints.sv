class c_988_4;
    bit[31:0] seq_id = 32'ha;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_988_4;
    c_988_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "010x11xxzxz10110xz00zxz10zx10011xzzzzxxzzxxxxzzzxzxxxxxxzxzzzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
