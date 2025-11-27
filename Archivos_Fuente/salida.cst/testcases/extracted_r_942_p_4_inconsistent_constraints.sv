class c_942_4;
    bit[31:0] seq_id = 32'h3;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_942_4;
    c_942_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "01zzzz10x1x1100x011x10zz0z0z0x00zzzxzxxzzxxxxxzxxzzxzzzzzzzzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
