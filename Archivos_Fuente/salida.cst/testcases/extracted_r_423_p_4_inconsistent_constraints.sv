class c_423_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_423_4;
    c_423_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "01zz110zx0z01xx0xx0z1z0xx010000zxxxzxxzzxzxxxzzzzxzzzzzzxzxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
