class c_1908_4;
    bit[31:0] seq_id = 32'h8;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1908_4;
    c_1908_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0zxx00xx110x00x1z011x000x0z000xzxxzxzzzzzzxzzzzzzzzzzxzxxzzxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
