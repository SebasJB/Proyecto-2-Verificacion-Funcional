class c_997_4;
    bit[31:0] seq_id = 32'hc;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_997_4;
    c_997_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz1x0x11xz111x1zx11zxx1z111z11x0xxzzzxzzxxzxzxxxzzxzxxxzzxxzzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
