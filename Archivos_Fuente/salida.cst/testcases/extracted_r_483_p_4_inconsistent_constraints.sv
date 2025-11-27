class c_483_4;
    bit[31:0] seq_id = 32'ha;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_483_4;
    c_483_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z00x1z01100x0x0z0101z0zzzzxzz1z1xzxxxzxxxzxzzxzzxxxzxxxzxzzxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
