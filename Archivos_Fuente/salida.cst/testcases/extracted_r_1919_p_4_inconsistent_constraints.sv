class c_1919_4;
    bit[31:0] seq_id = 32'hc;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1919_4;
    c_1919_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx0z0010zz1zzxz0000z0x101z001xzxxxxxzxzxzxxxzzzxxzxxzxzzxxxxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
