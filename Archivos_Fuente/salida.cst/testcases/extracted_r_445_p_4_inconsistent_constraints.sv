class c_445_4;
    bit[31:0] seq_id = 32'h4;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_445_4;
    c_445_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "11x0zz11x00zz1z001x1xz10x1zzzxx0zzxzzxxxzzxzxxzxxxxxzxzxxxxxxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
