class c_959_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_959_4;
    c_959_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zzzzx01x0zxxz0100xzx11011x111xx1xzxxxzzzxxxxxzzzzzzzxzxzzzzxxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
