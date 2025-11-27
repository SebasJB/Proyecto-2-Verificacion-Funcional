class c_1972_4;
    bit[31:0] seq_id = 32'h8;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1972_4;
    c_1972_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x1z101zx11xxzzxxxz1z1x1xxx1xz0xxxzzzxzxzxzxxxzzzxxzxzxxxxzzzzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
