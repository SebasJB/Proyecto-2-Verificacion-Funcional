class c_134_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_134_4;
    c_134_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0xx0z1001x1zx0z1z1x10z11zz0001xzxxzxzzzxxxxzzxzzzxxxxzxxxzzzxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
