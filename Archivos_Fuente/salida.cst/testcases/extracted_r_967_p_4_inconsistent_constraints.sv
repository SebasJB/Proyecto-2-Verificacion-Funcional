class c_967_4;
    bit[31:0] seq_id = 32'ha;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_967_4;
    c_967_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "111x1z101x011z1111x10zzz1010x0x0zxzzzzxxzzzxxxzxxxzzzzzxzzxzzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
