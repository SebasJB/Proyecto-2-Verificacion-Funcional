class c_1464_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h2;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1464_4;
    c_1464_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1100100x10xz0xz1x0z01000z1x10010zxzzxxzzzzzzzzxzzzxxzxzxxzxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
