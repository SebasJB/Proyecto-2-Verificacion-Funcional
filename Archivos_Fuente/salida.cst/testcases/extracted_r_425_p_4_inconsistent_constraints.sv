class c_425_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_425_4;
    c_425_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x11x0110x0z11111z11z1xxzz1zz0111zzzxzzxxzxxxxzxxzxxzzzxzxxzxxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
