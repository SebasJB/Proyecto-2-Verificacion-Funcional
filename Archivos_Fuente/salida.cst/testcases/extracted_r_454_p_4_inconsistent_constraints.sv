class c_454_4;
    bit[31:0] seq_id = 32'hd;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_454_4;
    c_454_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zzx00110101z0z0z01zzxxxzz1z11zz1xxxzxxxzzzzzzxxxxxzxzxxzxzxxxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
