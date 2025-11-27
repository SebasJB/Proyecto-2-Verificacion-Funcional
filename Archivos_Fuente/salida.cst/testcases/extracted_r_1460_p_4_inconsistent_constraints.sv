class c_1460_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1460_4;
    c_1460_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1z0z100z0zx0z0x0z1zx11z0z010x10zxxzxzzzzxxzzxzzxxzzxzzzzzxxxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
