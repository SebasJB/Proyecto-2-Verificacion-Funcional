class c_1339_4;
    bit[31:0] seq_id = 32'h5;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1339_4;
    c_1339_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx010z0x00xxx1110z1x01x1100xz111xxxzxxzzzzxzxzxxzxzzzxxzzxxxzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
