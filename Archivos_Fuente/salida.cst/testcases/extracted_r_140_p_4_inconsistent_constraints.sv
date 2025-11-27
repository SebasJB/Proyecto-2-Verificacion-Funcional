class c_140_4;
    bit[31:0] seq_id = 32'h5;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_140_4;
    c_140_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x11xx1000z0xz1xxx1xz1zzx1xx10z0xzzzzxxzzzxzzxxxzzzxzzxxzxxxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
