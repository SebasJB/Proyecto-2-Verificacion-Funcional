class c_1922_4;
    bit[31:0] seq_id = 32'h9;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1922_4;
    c_1922_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xxz0z10zzzxz0001x1z0z10xx0xxx01xzzxxzxxxxxxxzxzzzxxxzzzzxzzxxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
