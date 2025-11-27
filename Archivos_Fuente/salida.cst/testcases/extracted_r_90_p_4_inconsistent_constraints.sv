class c_90_4;
    bit[31:0] seq_id = 32'he;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_90_4;
    c_90_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1z00zz00zx0z011x0xzx111z101xxx1xzxxxzxxxzxzxxzxzzzzxzzzzzxzzzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
