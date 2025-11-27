class c_1878_4;
    bit[31:0] seq_id = 32'ha;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1878_4;
    c_1878_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z10z0x0x1zz00x0x110111xx110xx1x1zzxxxxzzzxzxxzxzxxzzxxxxzxxzxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
