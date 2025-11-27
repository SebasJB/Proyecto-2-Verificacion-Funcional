class c_417_4;
    bit[31:0] seq_id = 32'h8;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_417_4;
    c_417_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00zz1000x1zzzz0x1zxx0xx0xz0x0z10xxxzxzzzzxzxxzxxzzzxxzzxzxxzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
