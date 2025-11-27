class c_84_4;
    bit[31:0] seq_id = 32'h6;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_84_4;
    c_84_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z001x10x00xx1z0xzzx11z10z1zz1000zzzxzzzxzzzxzxzzzzzzxxzxxxxzxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
