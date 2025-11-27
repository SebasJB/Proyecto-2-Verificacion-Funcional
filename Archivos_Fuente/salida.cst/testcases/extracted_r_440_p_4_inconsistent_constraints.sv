class c_440_4;
    bit[31:0] seq_id = 32'h0;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_440_4;
    c_440_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0z11x1xxz0z1x11x01011x111z0z0zxxzzxxxxzzxzxzzzzxxzzzxxzxxzxxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
