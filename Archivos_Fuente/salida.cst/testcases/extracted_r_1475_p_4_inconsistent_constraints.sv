class c_1475_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h2;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1475_4;
    c_1475_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x010xx000x0z00100111z1z0zxz10z0zxzxzzzzxzxzzzxxzzzxxxxxxzxxzzxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
