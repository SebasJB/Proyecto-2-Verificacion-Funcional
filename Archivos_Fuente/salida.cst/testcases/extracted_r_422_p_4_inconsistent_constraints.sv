class c_422_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_422_4;
    c_422_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x01xzx1z101x1x00xz1zxxx11z0z1010zzxxzzzxzxxxzxzxzxxxzxzzzxxzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
