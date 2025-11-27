class c_1347_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1347_4;
    c_1347_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z01x10xx1zxzx101x0z0xx11z1xzx1x0xxzxzzzxxzzxxxxzzzxxzxxzzxxzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
