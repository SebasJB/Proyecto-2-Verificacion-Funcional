class c_1412_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1412_4;
    c_1412_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "001xz1z1xx01zxz1x00z0x01xzzzzzxxxzzzzxxzxzzzxxzxxxxxzxxzzzzxxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
