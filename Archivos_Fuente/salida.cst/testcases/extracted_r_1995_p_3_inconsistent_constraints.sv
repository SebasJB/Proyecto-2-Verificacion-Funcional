class c_1995_3;
    bit[7:0] pkt_id = 8'h0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:78)
    {
       (pkt_id == 8'hde);
    }
endclass

program p_1995_3;
    c_1995_3 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0111zz1x0x1z11zz100x1z1zx0xx0z0xxzzzxzzzzxxxxxzzxxxzzzxxzzzxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
