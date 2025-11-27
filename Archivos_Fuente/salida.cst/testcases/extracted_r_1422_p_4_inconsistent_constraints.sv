class c_1422_4;
    bit[31:0] seq_id = 32'h7;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1422_4;
    c_1422_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1zzx100z0zz1z0xzzx00z01zz110z10xzxzxxzxzxxxzzxzxxzxxxxzzxzzxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
