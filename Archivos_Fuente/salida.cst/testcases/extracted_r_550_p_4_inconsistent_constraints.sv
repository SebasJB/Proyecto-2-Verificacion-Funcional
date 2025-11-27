class c_550_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h2;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_550_4;
    c_550_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xzzxz1xzzz10x0x10zz10zzx1z0z10zzxzxzxzxxxzzzzxxzzxzxxxxxxzzzxxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
