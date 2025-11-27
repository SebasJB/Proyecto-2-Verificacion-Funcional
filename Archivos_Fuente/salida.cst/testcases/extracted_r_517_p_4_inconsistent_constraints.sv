class c_517_4;
    bit[31:0] seq_id = 32'hc;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_517_4;
    c_517_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zzz0x11zzx00001z1x11z00111xx11xxzzzzxxzxxzxxzxzxzzzzzzxxzzxxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
