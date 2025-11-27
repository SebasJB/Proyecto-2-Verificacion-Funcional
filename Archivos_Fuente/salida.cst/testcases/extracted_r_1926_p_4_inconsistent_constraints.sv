class c_1926_4;
    bit[31:0] seq_id = 32'h5;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1926_4;
    c_1926_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10xz0011zzzx00x1xxxz11z0xzzzxzx1zxxzxxxzzxxxzzxzzxxzxxxxzzzxxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
