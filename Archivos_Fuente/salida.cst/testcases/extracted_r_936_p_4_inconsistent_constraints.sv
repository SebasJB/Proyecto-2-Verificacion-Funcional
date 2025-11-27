class c_936_4;
    bit[31:0] seq_id = 32'h9;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_936_4;
    c_936_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zzxzx1xxx0xz010z11x101zx110z10xxxzxxzxxzzzzxzxzzxzzxzzzzxxzxxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
