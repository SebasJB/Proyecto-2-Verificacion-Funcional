class c_1960_4;
    bit[31:0] seq_id = 32'h3;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1960_4;
    c_1960_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0zxz01xzxx10xx1100zz01111xx011xxzzxxzxxzxxxxxzxxxxzzzzzzzxxxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
