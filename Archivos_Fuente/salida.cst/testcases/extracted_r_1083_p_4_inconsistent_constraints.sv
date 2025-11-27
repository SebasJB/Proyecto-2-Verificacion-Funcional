class c_1083_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h2;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1083_4;
    c_1083_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z11x0xx0zz1zx101010z100x1101xxzzzzxxxzxzxzzzxxzxzzxxxxzxzzxxxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
