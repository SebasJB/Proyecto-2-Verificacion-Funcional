class c_1975_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1975_4;
    c_1975_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "01x1010z0z0x10zx0zx0z00xz010001xzxzxzxxzxzxzxzxxxxzzxzzxzzzzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
