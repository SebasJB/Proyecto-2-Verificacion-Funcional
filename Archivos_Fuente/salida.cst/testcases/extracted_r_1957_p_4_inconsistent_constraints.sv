class c_1957_4;
    bit[31:0] seq_id = 32'h6;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1957_4;
    c_1957_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x1z1x100z01z01xxz0xz1x00z1110z11xxxzzxxxxxzxzzxzxzxxxzzxzxzzxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
