class c_47_4;
    bit[31:0] seq_id = 32'h8;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_47_4;
    c_47_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x1z010x1zxz1000z1z0z1xzzz0111z1xzxzzzxxxxzzzzxzxzzzxzxxzzxzxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
