class c_170_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_170_4;
    c_170_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0z01zz000x100x011000xx0x0x00x00xzxxxzzxxxxxxxxzxzxxxxzzzxxzzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
