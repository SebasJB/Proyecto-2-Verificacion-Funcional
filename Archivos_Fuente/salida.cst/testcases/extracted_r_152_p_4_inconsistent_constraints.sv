class c_152_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h2;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_152_4;
    c_152_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "111xx0xx1x1x0x0000z1z1xzzx110001zxzzxzxzxxxzzxxzxzzzxxzxxxxxxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
