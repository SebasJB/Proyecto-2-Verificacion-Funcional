class c_496_4;
    bit[31:0] seq_id = 32'h8;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_496_4;
    c_496_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00x00zxxzx1zx000z10xzz1100xx0x00zzzxxxzzxxxzxxzxxzxxxzxzxzxxxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
