class c_39_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_39_4;
    c_39_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0xz1xz100z01x0x11x0z0xz0zz01z11xzzzzzxxxxxzzzzzxzxzzzzzxxxzxxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
