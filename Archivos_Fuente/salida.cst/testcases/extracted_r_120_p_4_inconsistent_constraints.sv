class c_120_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_120_4;
    c_120_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xxxz1z0z011z0z1z0zx0xx1111100zx0xxxzzzxzxxxzxxzzzxxzzxxxxxxzxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
