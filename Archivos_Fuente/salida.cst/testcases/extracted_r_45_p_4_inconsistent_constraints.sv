class c_45_4;
    bit[31:0] seq_id = 32'h6;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_45_4;
    c_45_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xz1x011z10x0xz0zz1101xx011z0zz1xzzzzxxzxxxzzxzxzxzxxzzxxzxzxzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
