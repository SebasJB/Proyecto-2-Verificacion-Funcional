class c_1070_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h3;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1070_4;
    c_1070_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0z11z0x1010xxx11z1x000x0xz01z00zzxxxzxzxxxxxzzxxzzxxxzxxxxzxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
