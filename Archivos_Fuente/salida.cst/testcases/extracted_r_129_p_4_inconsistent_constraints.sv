class c_129_4;
    bit[31:0] seq_id = 32'h0;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_129_4;
    c_129_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x1z010z1xx0x1z1100x11z00z01x101zzxzzxxxxxzzzxxzxxzzzzxxxxxxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
