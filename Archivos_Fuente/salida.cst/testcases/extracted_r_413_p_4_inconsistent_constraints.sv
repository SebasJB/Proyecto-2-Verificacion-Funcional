class c_413_4;
    bit[31:0] seq_id = 32'h4;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_413_4;
    c_413_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0111zzzxzz10z0zzz1xzxx1zz01x0z0xzxxzzxxxzxzxxzzzzzxxzxzxxxzxxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
