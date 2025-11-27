class c_1949_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1949_4;
    c_1949_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zxzx0z000z011xz1z001z1x1z1011xx0xxxxzzxzzxxzxxxxxzzxzxxzxzxxzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
