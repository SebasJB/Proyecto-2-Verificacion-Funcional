class c_135_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_135_4;
    c_135_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zxz1001x10xz011x11zzz0x011x0xz0zxzxzxzzxzxzzxzzzxxzzzxxxzxzxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
