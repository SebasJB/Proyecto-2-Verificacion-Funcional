class c_399_4;
    bit[31:0] seq_id = 32'h9;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_399_4;
    c_399_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "110xx1zzxz0zx0x1x1x1xz0xx1z0z1z1xzxzxzzxxxzzzzzzxxzxxxzzzzxxxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
