class c_962_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_962_4;
    c_962_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1zx0zz1111xz10xx1z0z1zxxzx10z11xxxzxxzxxxzzzxzxxzxxzxzxzxxzxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
