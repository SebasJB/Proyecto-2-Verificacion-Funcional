class c_172_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h3;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_172_4;
    c_172_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1110x10xz1zz1z01zzzzzx0010x1100zzzzzxxzzxzxxzxxzzzzxxzzzxxxxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
