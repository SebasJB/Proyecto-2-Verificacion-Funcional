class c_536_3;
    bit[7:0] pkt_id = 8'h0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:78)
    {
       (pkt_id == 8'hde);
    }
endclass

program p_536_3;
    c_536_3 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x1010zxz0xz11zxx1z0xz01xx1zzz1zxxzxxxxxxxxxzzzzzzxxxzzxxzxzxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
