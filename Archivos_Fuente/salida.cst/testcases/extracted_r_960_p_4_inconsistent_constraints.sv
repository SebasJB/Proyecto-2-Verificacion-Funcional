class c_960_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_960_4;
    c_960_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00xx1z010zx1001x0110zxxzz000001xzxxxxzzzzxxxzzxzzzxzzxxxxxxxxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
