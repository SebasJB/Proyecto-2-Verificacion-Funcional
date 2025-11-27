class c_1345_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1345_4;
    c_1345_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00001xz0z0x00x1zzz00z1zz11x01101xxzxxzzxzxxxzxxxzzxxzzxxxzzzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
