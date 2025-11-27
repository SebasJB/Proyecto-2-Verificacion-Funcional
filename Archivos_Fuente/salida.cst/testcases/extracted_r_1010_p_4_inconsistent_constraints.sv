class c_1010_4;
    bit[31:0] seq_id = 32'h0;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1010_4;
    c_1010_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zzzzz0x1xxxz0x1xx10xx01011z0xz0zzzxxzxxzxxzzzxzzzzzzxxzzzxzzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
