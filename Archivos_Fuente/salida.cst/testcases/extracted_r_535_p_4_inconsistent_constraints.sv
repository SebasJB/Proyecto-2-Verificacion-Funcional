class c_535_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_535_4;
    c_535_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z1xz011x1z1zxxxx10x01000x1001x11zzxzxzzxxzzzxxxzzzxxxzzxxxxxzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
