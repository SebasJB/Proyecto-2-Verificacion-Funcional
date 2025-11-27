class c_160_3;
    bit[7:0] pkt_id = 8'h0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:78)
    {
       (pkt_id == 8'hde);
    }
endclass

program p_160_3;
    c_160_3 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "100x1zzzx000zzzx11xzxxx0xxzxzzxxxzzxzzxxxxzzxxxxxzxxxzzxxzxzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
