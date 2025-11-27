class c_424_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_424_4;
    c_424_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x11zx1z1zx0xx00xx1z0xzzx010x0100zxxxxxxxzxxxxzxzxzxxxxzzxzxxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
