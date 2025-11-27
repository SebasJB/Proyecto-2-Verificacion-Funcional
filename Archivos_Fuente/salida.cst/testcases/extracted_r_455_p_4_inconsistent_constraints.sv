class c_455_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_455_4;
    c_455_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zzx11z1x1zx0xx1x0z111z1zz00x00zzzxxxzzzxxzzxzzzxxxzxxxzxxzzzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
