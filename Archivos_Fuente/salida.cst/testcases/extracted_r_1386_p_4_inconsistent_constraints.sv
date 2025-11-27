class c_1386_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1386_4;
    c_1386_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0000xzzz0x101x1z0zx100x100x0010zxzzxxxzzzxzzxxzzxxxzxzxzxxxxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
