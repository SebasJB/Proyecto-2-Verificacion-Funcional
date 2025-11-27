class c_980_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_980_4;
    c_980_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xxxz0z1z0z01xx0xx011zzx01zxzx01xxxxxzzzxzxxxzxxzzzzxxzxzxxxxxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
