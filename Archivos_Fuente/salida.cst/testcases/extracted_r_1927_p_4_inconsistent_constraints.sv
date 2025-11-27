class c_1927_4;
    bit[31:0] seq_id = 32'h4;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1927_4;
    c_1927_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00xzxxzx0x10z1xxx0zz01x1xx1xxxz1xzxzzzzzzzzzzxxxzxxxzxxzzzzzxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
