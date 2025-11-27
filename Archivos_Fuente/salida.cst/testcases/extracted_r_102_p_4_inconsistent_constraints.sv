class c_102_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_102_4;
    c_102_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xz0xzx0zxx0xx1x0z1z001xz11xz01z1xxzxzxzxzxzzzzxzxzxxzzxxzzzzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
