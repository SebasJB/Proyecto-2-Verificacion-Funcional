class c_1356_4;
    bit[31:0] seq_id = 32'h9;
    bit[7:0] pkt_id = 8'h0;
    integer t = 1;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1356_4;
    c_1356_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1xz111x0110z1x0z00z1z1x11101z11zzxxzzxxxxzxzzzxzzxzxxzxxxxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
