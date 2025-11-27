class c_2016_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h2;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_2016_4;
    c_2016_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x00xx0x11zzzx11z0z10z1z0xz101x0zxzzzxxzzzzzxxxzzzxxxxzxxxxxzxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
