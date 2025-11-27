class c_91_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_91_4;
    c_91_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zx00zzz11zx111011zxx11zz11z0xx0zxxzzxzzxxzzzxxzxzzxzzxzxzzzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
