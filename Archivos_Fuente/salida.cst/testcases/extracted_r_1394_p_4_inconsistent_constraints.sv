class c_1394_4;
    bit[31:0] seq_id = 32'h3;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1394_4;
    c_1394_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zzz1xz01zxz1x10z11z0100z1x1xx11zxzzxzzzxxzxzxzzzxzzzzzzxzxzzxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
