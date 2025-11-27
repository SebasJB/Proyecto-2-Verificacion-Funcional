class c_1958_4;
    bit[31:0] seq_id = 32'h5;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1958_4;
    c_1958_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "000111000x00x0xzzxz1z101xzx0z1z1xxzxxxxzxzxxzzxxxxzzxzzzxzzzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
