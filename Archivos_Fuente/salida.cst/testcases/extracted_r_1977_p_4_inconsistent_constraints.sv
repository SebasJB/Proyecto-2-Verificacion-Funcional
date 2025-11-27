class c_1977_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1977_4;
    c_1977_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x010z1x10111z0x0000x1zzz0x00zzxzzxxxzzxzxzxzzzxzxxxzxzzxzxxzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
