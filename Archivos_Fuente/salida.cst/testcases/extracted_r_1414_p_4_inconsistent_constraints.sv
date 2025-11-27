class c_1414_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1414_4;
    c_1414_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz000xzz1001x1z1x01z001zxx0xx011xxxzxxzzxxzxxzzxzxzxzzxxxxxzxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
