class c_935_4;
    bit[31:0] seq_id = 32'ha;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_935_4;
    c_935_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1z0xz01x0z0zxxzz1000001z1z0z1zzzzzzxzzxxzxxzxzzxzxxxxxxzxxxzzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
