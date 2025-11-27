class c_1007_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1007_4;
    c_1007_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x0zzx1x1xx1zx1z1x1x0x01xx1100x0xxxzzxzzzzxxzzxzxzxxxxzxzxxzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
