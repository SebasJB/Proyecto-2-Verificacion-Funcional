class c_1087_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1087_4;
    c_1087_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz0z00z11zxx101xx0zxz1zz0xxx11x1zzxzxzxzzzxxxxxxxxzxxzxxxzxxzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
