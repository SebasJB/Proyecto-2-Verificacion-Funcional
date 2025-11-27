class c_1886_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1886_4;
    c_1886_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0xz00zzzzz10110z110zz100z1zx1xxzzxxzzzzzzxzxxzxxxxzzxxzxxxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
