class c_1432_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1432_4;
    c_1432_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "000xx110x1zz01001xz10xz01xx1x1x0xzxxzxzxzzzzxzxzxxxzzxxxzxzxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
