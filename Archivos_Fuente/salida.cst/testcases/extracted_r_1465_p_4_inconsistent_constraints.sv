class c_1465_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h3;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1465_4;
    c_1465_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "111z0zx1xzx01x11x100110x011xzzzzxxzzzzxzxxzxzxxxxxzxzxxxxzzzxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
