class c_952_4;
    bit[31:0] seq_id = 32'h6;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_952_4;
    c_952_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1z00x1100001zzz0z01x00x010zx1zxxzxxxzxxxzxxzxxzxzzxzzzxzxxzxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
