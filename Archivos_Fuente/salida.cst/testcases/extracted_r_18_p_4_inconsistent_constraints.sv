class c_18_4;
    bit[31:0] seq_id = 32'h8;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_18_4;
    c_18_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1z00zx0011x101z0x11xz0x11zx111xzxxxxzzxzxxzxzzzxzxxxzzxxzzzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
