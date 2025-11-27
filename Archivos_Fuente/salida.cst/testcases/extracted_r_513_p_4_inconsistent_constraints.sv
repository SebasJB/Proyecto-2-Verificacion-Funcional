class c_513_4;
    bit[31:0] seq_id = 32'h8;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_513_4;
    c_513_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xzxz0x0zz11z10110x00zzx0z1xx01zzzxzzzxzxxxxxzzxzzxxzxxxzxzzxxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
