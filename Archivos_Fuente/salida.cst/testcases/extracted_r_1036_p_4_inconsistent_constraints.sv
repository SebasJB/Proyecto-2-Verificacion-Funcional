class c_1036_4;
    bit[31:0] seq_id = 32'h5;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1036_4;
    c_1036_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1z0zx1xxzz0zx10xxxxxxxz10x0000z0xxzzxzzzzzzxzzxxxxxxzxxzxxxzzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
