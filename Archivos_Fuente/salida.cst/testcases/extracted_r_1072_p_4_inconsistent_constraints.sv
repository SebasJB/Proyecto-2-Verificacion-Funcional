class c_1072_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1072_4;
    c_1072_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "011x0110zzx1z111100x10x1x000z1x1xzxxxzxzxzxxzzzzzxzzxxzzzzzzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
