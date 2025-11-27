class c_415_4;
    bit[31:0] seq_id = 32'h6;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_415_4;
    c_415_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0x1z010zz1z0xx1x1xzz11x00x01x10xzzxzxzxzxzzzzzxzxzxxzxxxxxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
