class c_1871_4;
    bit[31:0] seq_id = 32'h3;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1871_4;
    c_1871_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1x01111xx01x10x0zzzzz101z10001z1xxzzxxxxxzzxzxxxzxxzxxzxzxxxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
