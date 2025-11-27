class c_1056_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1056_4;
    c_1056_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0z1xx0001z0x11z00zz1xzx1zxz010x0zxzxxzzxxzzzxxzzxxzxzzxzzxxzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
