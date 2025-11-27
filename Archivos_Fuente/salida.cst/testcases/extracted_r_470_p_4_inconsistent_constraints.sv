class c_470_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_470_4;
    c_470_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x01x1x111z11x0zxxx11x11x1z101x1zzzxzxzzxxzxzzzzzxxxxxzxzxxzzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
