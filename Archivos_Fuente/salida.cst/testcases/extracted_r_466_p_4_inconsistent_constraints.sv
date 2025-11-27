class c_466_4;
    bit[31:0] seq_id = 32'h6;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_466_4;
    c_466_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x1xzz1zz10x1zzzxzzxxxz00zx01zxz0zzxxzxzxzzzzxxzzxxxzzxxzzxxzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
