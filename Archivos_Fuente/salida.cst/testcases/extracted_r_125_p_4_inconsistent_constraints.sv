class c_125_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_125_4;
    c_125_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zxz0xz0z1x10zxx01x0011x1x0000xz0xzzzzxzzxxzzzxxzzxxzxzzxxzzxxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
