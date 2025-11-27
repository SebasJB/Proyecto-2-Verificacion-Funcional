class c_505_4;
    bit[31:0] seq_id = 32'h0;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_505_4;
    c_505_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x1x1010z1zz0zzx011x1zzzz0x000x11xzxxxzzxzxzzzxzzzxzxxzxzxxzzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
