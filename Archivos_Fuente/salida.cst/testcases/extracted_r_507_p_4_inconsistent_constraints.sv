class c_507_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_507_4;
    c_507_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z11000x01111zx10zzzx0z00z0x10z0zzzxzxxzxzxxzxxzxzzxzxzzzxzzxzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
