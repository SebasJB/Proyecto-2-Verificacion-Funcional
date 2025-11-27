class c_163_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h2;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_163_4;
    c_163_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xzx0zx0zz0110z100x0zz111xx10zx10zxxzxzxzzzxzxxzxxzxxzxzzxzxxzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
