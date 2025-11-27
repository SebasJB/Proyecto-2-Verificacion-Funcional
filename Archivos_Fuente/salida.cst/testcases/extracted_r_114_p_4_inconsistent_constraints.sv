class c_114_4;
    bit[31:0] seq_id = 32'h8;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_114_4;
    c_114_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx1110zxz0x0110zx11xzzx101001xxzzxzxzxzzzxxxxzxxzxxzzxzzxxxxzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
