class c_1380_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1380_4;
    c_1380_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zxxxzzx1z0x11z10xzx1zz11zxzxx10xxxxzxzzzxzzzzxzxzxzzxzxzxzxxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
