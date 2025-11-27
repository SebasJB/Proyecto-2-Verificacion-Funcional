class c_42_4;
    bit[31:0] seq_id = 32'h3;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_42_4;
    c_42_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zxx1x1zxxx1x11xxx010xxx10zzxz10xzxxzzxzxzzxxxzxzzzzxxzxzxzzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
