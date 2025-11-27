class c_1032_4;
    bit[31:0] seq_id = 32'h9;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1032_4;
    c_1032_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0zzxz0xxx1011xz0zxzz1x11z1z110xxxxzxzzzxzxxxzzxxxzzxxxzxxxxzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
