class c_1954_4;
    bit[31:0] seq_id = 32'h9;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1954_4;
    c_1954_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00x1xxxx00z0x1001x01x0zz0xzz1z10xxzxzxxzzzzzxzxxzxzxzxzzxxzzzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
