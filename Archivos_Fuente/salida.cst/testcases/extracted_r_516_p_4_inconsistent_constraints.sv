class c_516_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_516_4;
    c_516_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0xzxx10zz01x00x00x10zzz0zz11z01xzxxzxxxxzxzzxxxzxxxxxzzzzzzxxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
