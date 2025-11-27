class c_438_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_438_4;
    c_438_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0z101z0000xz100z1xxz100zzx0x1zzxxzzzxzxzxzzxzzxzzxzzxxzzzzzzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
