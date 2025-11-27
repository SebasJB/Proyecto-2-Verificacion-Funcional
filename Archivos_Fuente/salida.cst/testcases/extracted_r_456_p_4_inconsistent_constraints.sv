class c_456_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_456_4;
    c_456_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xz1x01z0zx1z00100xxxx11xz01z11x0zxxxxxzxzxzxzzzxxxxzzxzzzzzxxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
