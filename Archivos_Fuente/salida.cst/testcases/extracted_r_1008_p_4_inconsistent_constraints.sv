class c_1008_4;
    bit[31:0] seq_id = 32'h1;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1008_4;
    c_1008_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00zzz10z0z1xz11xx10z01xx0z10z1zzzxxxzxxzxzzxzzxxzzxxzxzzzzzzzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
