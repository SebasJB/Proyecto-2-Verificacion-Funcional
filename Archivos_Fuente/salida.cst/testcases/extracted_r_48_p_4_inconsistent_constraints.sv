class c_48_4;
    bit[31:0] seq_id = 32'h9;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_48_4;
    c_48_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz0z0z1z0x1z111x1001zxxxzxxzx101xzzzxzxxxzzzxzxxxxxxzxxxzzxxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
