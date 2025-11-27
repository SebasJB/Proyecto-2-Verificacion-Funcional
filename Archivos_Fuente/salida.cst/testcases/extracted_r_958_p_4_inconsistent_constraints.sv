class c_958_4;
    bit[31:0] seq_id = 32'hc;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_958_4;
    c_958_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx1zz11zzz1zx0xzx0101z1z10zxz100xzzzxzxxzzzzxxxxzxxxxxzzxxxzxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
