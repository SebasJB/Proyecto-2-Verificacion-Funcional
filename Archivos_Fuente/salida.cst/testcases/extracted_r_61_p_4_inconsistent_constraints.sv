class c_61_4;
    bit[31:0] seq_id = 32'hb;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_61_4;
    c_61_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0xzzx0x10x0x0x1xxz1z10xzz1x010zxxxxxzzxxxxzzzxxxzxxxxxxxzxxzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
