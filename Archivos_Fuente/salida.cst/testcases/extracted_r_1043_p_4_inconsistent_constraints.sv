class c_1043_4;
    bit[31:0] seq_id = 32'h1;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1043_4;
    c_1043_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx0zxz1010xz1xz0x000111xx100xx0xzzzxxxzzzxzzzzzzxzzxxzxzxxxxxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
