class c_1932_4;
    bit[31:0] seq_id = 32'h0;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1932_4;
    c_1932_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "11x01100z00xxzzzx0xxx0x1x0z0x1xxxxzzzxzzxxzzxzzzzxxxxzxzxzxxzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
