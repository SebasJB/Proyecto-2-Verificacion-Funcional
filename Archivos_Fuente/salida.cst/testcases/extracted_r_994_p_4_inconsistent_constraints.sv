class c_994_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_994_4;
    c_994_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx0xz0xzxz1x10zx01xz1z1z0zz1zx1xzxzzxxzzzzxxxzzzxxzzzxzzzzzzxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
