class c_1026_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1026_4;
    c_1026_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10z1zzx01zx1x1001010zxzxzz0z1z00zzzzxzzxxxxzxzxzxzzxzxzzzzzzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
