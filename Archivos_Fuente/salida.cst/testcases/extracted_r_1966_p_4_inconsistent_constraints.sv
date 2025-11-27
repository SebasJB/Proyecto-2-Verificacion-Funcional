class c_1966_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1966_4;
    c_1966_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1x10z1x01xz1zzxx1zx10xzxz1z001xxzxzzxxzxzzxzxxzxzzzzzxxzxzzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
