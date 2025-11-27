class c_1340_4;
    bit[31:0] seq_id = 32'h6;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1340_4;
    c_1340_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0z0xz1z0zzzxxzzz0111x101xx1xxx1xxxxzxzxzxzzxzxzxxxxxzxzzzzxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
