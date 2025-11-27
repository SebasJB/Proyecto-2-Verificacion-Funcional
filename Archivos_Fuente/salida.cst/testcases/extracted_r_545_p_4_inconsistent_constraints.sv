class c_545_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h2;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_545_4;
    c_545_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz0zzx0z1xz1x1z0xxxx0z1x1xxx11x1xzzxzzxzxzxxzzzzzzxxxxxxzxzzzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
