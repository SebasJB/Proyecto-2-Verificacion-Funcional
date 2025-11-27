class c_1853_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1853_4;
    c_1853_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xzzxz1xx110110x0zxx1xzz1001zx10zxzxzxzxzxzzzzxxxzxzzxzxzzzxzzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
