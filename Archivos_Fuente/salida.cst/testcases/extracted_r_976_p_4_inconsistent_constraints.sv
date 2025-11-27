class c_976_4;
    bit[31:0] seq_id = 32'h1;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_976_4;
    c_976_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x1zx11zzz10xxxzxxz1z11x0xz00xxz0zzxzzxzzxzxxxzxxzxzzzxxxxxxzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
