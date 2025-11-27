class c_957_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_957_4;
    c_957_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1z1001x110x0zz0x01zx0xx01xxx0xzzxzzxzzxzzxzzxxzzzxxzxzxzxzzzzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
