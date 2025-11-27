class c_1031_4;
    bit[31:0] seq_id = 32'ha;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1031_4;
    c_1031_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z00x0z1zz0x0xx1z01x110100zxx0111zzxzxzxzxzxzzxxzzzxzxxxzxzzxxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
