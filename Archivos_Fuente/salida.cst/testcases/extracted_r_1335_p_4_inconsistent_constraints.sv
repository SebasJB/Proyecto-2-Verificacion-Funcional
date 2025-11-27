class c_1335_4;
    bit[31:0] seq_id = 32'h1;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1335_4;
    c_1335_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "11z0z1x0z0001x0x10110zzz1z1xxzx1zxxzxzzxzxzxxxxxxzxxxzxxxxzzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
