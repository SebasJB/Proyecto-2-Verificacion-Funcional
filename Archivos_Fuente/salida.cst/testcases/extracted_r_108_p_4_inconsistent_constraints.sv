class c_108_4;
    bit[31:0] seq_id = 32'h5;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_108_4;
    c_108_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x10x1xzz00z1xzzz0x1xx1zx1z1x1010zzzxxzxzzzxxxzzxxxxzxxzzzxzxxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
