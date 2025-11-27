class c_105_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_105_4;
    c_105_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1xzz0z0zx0z1z0xx11z11x11z011x01xzzxxxxzzxxzxxzxzzxzzxxzzxzxxxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
