class c_458_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_458_4;
    c_458_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00xxxz1z0xzx1x100x0xx1zxz0zzzzx1xzxzzzxxzxzzxxxxxxxzzzzzzxzzxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
