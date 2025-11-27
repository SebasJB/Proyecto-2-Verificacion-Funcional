class c_1089_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h3;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1089_4;
    c_1089_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xxzz1x1z0x101z0z0x11001x1zz1xx11xxzxzzxzxzzzzzxzzzzzzzxxxxzzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
