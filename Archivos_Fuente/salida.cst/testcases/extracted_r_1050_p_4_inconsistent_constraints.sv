class c_1050_4;
    bit[31:0] seq_id = 32'h8;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1050_4;
    c_1050_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0z00z1101xzx001z0z00x00x1z1xzx1zxzxxzzzzxxzzxxzzxzxzxxxxxxxzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
