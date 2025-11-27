class c_512_4;
    bit[31:0] seq_id = 32'h7;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_512_4;
    c_512_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz0z0111zzxzx001z1011x11z00zz000zzzxxzzzzxxzxxzzzzxzxzxzzxzxzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
