class c_420_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_420_4;
    c_420_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z11x0z0x10111xx0x0zxx00xz0110z0xzzzzxzxxzzxxzxzzzzxxzxzzzzxzxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
