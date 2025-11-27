class c_1054_4;
    bit[31:0] seq_id = 32'hc;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1054_4;
    c_1054_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xz010x010x1xz1x1zxzzz1001xx1zx1xzzzzxzzzxzxxzxxxxzzzxzzxzxxzzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
