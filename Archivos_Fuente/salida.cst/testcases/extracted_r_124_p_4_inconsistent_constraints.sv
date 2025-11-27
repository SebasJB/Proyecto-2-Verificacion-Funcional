class c_124_4;
    bit[31:0] seq_id = 32'hc;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_124_4;
    c_124_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x10z1x0x01xx1x1xxx1xzzx1z1110z1zxxxzxzzzxzxzxzxxxzxxxzxzxxzxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
