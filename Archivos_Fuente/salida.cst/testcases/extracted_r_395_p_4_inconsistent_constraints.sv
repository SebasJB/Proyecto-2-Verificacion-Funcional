class c_395_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_395_4;
    c_395_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1z11x10zxz0zz00zz0x0x1z1xz1111z0zzzxxxxzxzxzxxxxxzxzxxzzzzzzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
