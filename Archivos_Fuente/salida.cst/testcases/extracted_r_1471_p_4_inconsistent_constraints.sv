class c_1471_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1471_4;
    c_1471_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1zzz1zzx11x01x0100xxzx0zx0xxxx11zxxxzxzxxxzxzxxzxzxzzzxxzzzzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
