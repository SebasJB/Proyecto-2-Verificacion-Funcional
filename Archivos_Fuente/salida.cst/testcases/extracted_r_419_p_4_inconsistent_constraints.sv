class c_419_4;
    bit[31:0] seq_id = 32'ha;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_419_4;
    c_419_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0z0xx0xzx0zz11z0zx00xz1010xzzx0xzxzxxzxzzzzxzzzxzxzzxzxxzzzxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
