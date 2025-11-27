class c_977_4;
    bit[31:0] seq_id = 32'h0;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_977_4;
    c_977_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xz00x001zzxx0x00xx0101z1xz001zzxxxzxxzzxxxzxzzzxzzzzxzxzzzzzxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
