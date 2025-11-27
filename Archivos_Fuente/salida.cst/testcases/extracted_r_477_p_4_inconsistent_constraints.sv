class c_477_4;
    bit[31:0] seq_id = 32'h4;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_477_4;
    c_477_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x00xz0z0x0x00zx01x10x0z0zxxzz1z1xzxzxzxzxxzzzxzxxxxzxxzzzzzxxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
