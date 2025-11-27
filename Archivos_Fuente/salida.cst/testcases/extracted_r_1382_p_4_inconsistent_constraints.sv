class c_1382_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1382_4;
    c_1382_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z011xxxx000x1zz00xz1010x1x1z1110zxxxzzzxxxxzzzzzxxzzxzxzzzxxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
