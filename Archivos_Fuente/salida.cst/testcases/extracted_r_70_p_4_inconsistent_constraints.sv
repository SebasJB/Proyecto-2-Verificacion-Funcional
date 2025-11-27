class c_70_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_70_4;
    c_70_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0011z101xzxxxx010z1x11xz00xzzxxxxxzzxzzxxxxzxzxzxzzxzxzxxxzzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
