class c_1948_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1948_4;
    c_1948_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "01z011110111z0x1011zz00zx0z1z1xzzxxzxzxxxzxxxzzxxxxzxzzxxzzxzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
