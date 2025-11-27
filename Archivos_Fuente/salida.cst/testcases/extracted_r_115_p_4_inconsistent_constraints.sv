class c_115_4;
    bit[31:0] seq_id = 32'h7;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_115_4;
    c_115_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0z1z1001zx1zxxz1z01zz10101z1x001zzxzxzzzzxzzxzxzzzzxxzzzxxxxxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
