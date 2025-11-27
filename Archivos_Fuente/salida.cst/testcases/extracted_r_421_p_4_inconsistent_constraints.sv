class c_421_4;
    bit[31:0] seq_id = 32'hc;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_421_4;
    c_421_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1z0x1zxz1zz011zx00xxxx11zx10z10xxxzxzxzxxzxzxxzzzzzzzxzzxxxzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
