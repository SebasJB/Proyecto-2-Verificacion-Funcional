class c_1082_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h3;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1082_4;
    c_1082_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "100xx0z0zz1zzzxzz0xzzxzzx10zzzzxxxxxxxxxxxxzzzxxzxzzzxxzxzxzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
