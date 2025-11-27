class c_443_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_443_4;
    c_443_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0x110z0zzz0zzxxx1z010xz11zz101z1xzxxzxxzzxzxxxxxxxzzzxxzxxxxzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
