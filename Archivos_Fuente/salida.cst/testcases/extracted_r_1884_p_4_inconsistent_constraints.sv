class c_1884_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1884_4;
    c_1884_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0111xzxxxzzxzxzx0110zx0zzz00z1x1zxzzzxxxxxxxxxxzzzxxxzxzzzxxzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
