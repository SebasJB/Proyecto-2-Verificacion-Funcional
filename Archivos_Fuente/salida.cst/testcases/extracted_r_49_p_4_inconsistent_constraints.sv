class c_49_4;
    bit[31:0] seq_id = 32'h9;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_49_4;
    c_49_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "11011zzxzx0z0x0x0x1z0x11z1x0z0z1xzxzxzzzxxxzzxxxzxzzxzxxxxxzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
