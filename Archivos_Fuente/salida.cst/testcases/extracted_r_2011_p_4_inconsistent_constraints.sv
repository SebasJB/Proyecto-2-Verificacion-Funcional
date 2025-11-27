class c_2011_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h2;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_2011_4;
    c_2011_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "0011xzxx01xz0x0xx00zz10xx1x0x1x0xxzxxxxzxxzxxzzxxxxxzxxzxxxzxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
