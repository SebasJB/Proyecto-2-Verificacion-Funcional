class c_1047_4;
    bit[31:0] seq_id = 32'h5;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1047_4;
    c_1047_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xxz1xxz1z1zx0z00x0zxzz11z0z0xx00xzxxzxxxzxxxxxxzxzxxzzxxzxxzxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
