class c_1905_4;
    bit[31:0] seq_id = 32'h5;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1905_4;
    c_1905_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xz11z10z1zx01zx100zzzzz0x00x10z0zxzxxxxzxzxzzzxxzxzzzzxxzxxxzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
