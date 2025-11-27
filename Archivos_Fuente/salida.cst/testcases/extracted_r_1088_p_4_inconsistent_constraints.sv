class c_1088_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h2;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1088_4;
    c_1088_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zx110z0zz1001z1x1zxzxxxx10100zxzzxxzzzzzzzzzxzxzxzzzzzzxxxzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
