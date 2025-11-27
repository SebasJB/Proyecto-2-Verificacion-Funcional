class c_1005_4;
    bit[31:0] seq_id = 32'h4;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1005_4;
    c_1005_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x0z1zxx1x1xxx0z0xzzzzzzzz10x001zzzxxxzxzzzzzzzzxzxxzxxxzxxxxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
