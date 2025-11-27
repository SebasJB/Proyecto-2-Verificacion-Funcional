class c_1360_4;
    bit[31:0] seq_id = 32'h5;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1360_4;
    c_1360_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0z10xzzxzzxz0zz1z1x1x1x0z10zxz1xxzzxzxxzzxzzzxxzxzzxxzxxzxxxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
