class c_1929_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1929_4;
    c_1929_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx0zzx100zxx1xx0000x01x10zz11xxxzxzzzzxzzxzzzzzxxzzxzzxxxzzzxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
