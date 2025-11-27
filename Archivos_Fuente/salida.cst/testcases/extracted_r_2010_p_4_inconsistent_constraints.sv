class c_2010_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h3;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_2010_4;
    c_2010_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0xzz11z11zzx0zz0x00xz1xzzx0011zxxxzxzzxzzzxzxxxzzzxzxxzzzxzxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
