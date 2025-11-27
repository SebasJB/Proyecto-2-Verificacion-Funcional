class c_1461_3;
    bit[7:0] pkt_id = 8'h0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:78)
    {
       (pkt_id == 8'hde);
    }
endclass

program p_1461_3;
    c_1461_3 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1xzx00x011z1011x0110xx11x11xzz11xzxxxxzzxzxxzzxxzxzxxzxzzxxzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
