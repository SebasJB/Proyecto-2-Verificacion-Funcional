class c_1978_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1978_4;
    c_1978_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x1xzzxzz111zx010x01011001xzzz1xzxzxzzxxzzzxxzzzxxxxzxxzzzzxxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
