class c_96_4;
    bit[31:0] seq_id = 32'h0;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_96_4;
    c_96_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x1z01xx0x1zx10xx110z0z1zxz01xxx1xzzxzxxxzzxzzzzxxxzxzxzzzzxxzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
