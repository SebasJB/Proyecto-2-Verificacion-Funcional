class c_933_4;
    bit[31:0] seq_id = 32'hc;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_933_4;
    c_933_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10xxx00zzz0zz11z0z0z10xx101zxxx0zzxxxzxxxxxzxxzzxzzzxxxxzxzzzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
