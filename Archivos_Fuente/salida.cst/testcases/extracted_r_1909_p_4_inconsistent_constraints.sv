class c_1909_4;
    bit[31:0] seq_id = 32'h9;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1909_4;
    c_1909_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z01z0x101z0zx0x00z011zx100zzz0x0zzxzxxxzxzzxxzzxzzxxxxxxzzxzxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
