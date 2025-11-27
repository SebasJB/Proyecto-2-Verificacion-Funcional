class c_956_4;
    bit[31:0] seq_id = 32'ha;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_956_4;
    c_956_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "11x11x0xxx01zxxz1z0zz000xz1x1z00xzzxzzzzxxxxxzzxzzzzxzzxxzzzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
