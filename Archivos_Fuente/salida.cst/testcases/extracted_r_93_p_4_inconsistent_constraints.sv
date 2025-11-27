class c_93_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_93_4;
    c_93_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xz1z01z0zzx11zzz00x10z010z001zxxzxzxxxzzxxzzzzxzzxzzxzxzxzzxxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
