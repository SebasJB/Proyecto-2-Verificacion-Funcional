class c_441_4;
    bit[31:0] seq_id = 32'h0;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_441_4;
    c_441_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z01z0z1xzz0zzx101x11z00xz01zz1x0zzzxzxzzzxxxzzzzxxxxxzxxzxzzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
