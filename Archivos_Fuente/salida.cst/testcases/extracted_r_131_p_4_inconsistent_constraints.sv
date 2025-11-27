class c_131_4;
    bit[31:0] seq_id = 32'ha;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_131_4;
    c_131_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx1z0x0x0z011zx10x011z1zzzz11xzxxzzxxzzzzzzxxxxzzxxzzzzzzxxxxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
