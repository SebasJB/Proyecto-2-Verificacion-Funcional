class c_1006_4;
    bit[31:0] seq_id = 32'h3;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1006_4;
    c_1006_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "11xz1xx00z0zxz0zzx00z0x1zz00111xzxxzzzzxzzzxzxzxzxxxzzxzxxzxxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
