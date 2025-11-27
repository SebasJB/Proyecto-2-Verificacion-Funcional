class c_478_4;
    bit[31:0] seq_id = 32'h5;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_478_4;
    c_478_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z01z1zz0zz00z1xz101x0z1z10z1zzzzxxzzzzzzzzzxxzzxzxzzxzzzxzxzxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
