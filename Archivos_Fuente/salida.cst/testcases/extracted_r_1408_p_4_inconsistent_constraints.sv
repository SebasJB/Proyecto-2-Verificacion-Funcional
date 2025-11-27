class c_1408_4;
    bit[31:0] seq_id = 32'ha;
    bit[7:0] pkt_id = 8'h0;
    integer t = 2;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1408_4;
    c_1408_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1x0zz1z1101z1xxx1xx00z0zzxz001zxxxxxxxzzzxxzzzzzzxxzxzzzzzxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
