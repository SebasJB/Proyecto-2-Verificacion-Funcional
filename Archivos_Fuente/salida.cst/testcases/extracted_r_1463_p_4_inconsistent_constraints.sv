class c_1463_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1463_4;
    c_1463_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x001z11xxxz1x1zx0zz001zx1xz1zzxxxxxzzzzxzxzxzxxxxzzxzxxzzzxxxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
