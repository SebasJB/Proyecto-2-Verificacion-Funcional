class c_951_4;
    bit[31:0] seq_id = 32'h5;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_951_4;
    c_951_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "01x0xzxxx10xx1x1x0x011x0101z0z10zzxxzzxzxzzzxzxxxxzxxxxzzzzxxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
