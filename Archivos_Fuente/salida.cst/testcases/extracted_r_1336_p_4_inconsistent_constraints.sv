class c_1336_4;
    bit[31:0] seq_id = 32'h2;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1336_4;
    c_1336_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "11zx0110zz000x0zz01x1xz1111xzzx1zxzzzxzxxzxxzzzxzxzzzxzzzxxxxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
