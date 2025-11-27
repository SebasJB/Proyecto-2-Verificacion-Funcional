class c_480_4;
    bit[31:0] seq_id = 32'h7;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_480_4;
    c_480_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10z1x0x0xz111xz001x11zzz00xz1x00xxzzxxzxzxxzzzzxzxzxzxxxzzzzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
