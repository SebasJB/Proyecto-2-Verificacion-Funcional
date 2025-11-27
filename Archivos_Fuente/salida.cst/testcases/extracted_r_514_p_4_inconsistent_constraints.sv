class c_514_4;
    bit[31:0] seq_id = 32'h9;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_514_4;
    c_514_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0x1zx0xzxz1x1xx010x0z1z1z101x101zxzxxxxxxzzzzzzxxxzzzxxzzzzzzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
