class c_122_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_122_4;
    c_122_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0x0xxx11xxx1xzx0x01zz0x1zx1xxz1zxzzzzxzzzzzxzzxzxzxzxzxxxzxzzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
