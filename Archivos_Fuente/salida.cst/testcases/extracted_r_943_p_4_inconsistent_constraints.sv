class c_943_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_943_4;
    c_943_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xxzxxzzx00xx1xz1zzz111zzz1zz01zxzzzxzzzxxxxzzxzzxzxzzxxzxzzxzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
