class c_1474_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_1474_4;
    c_1474_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z0zzzzzx1100z0x0z011x11z01xz110xxxzzxxzzxzzxzzxxxxzxzzxzzzzxzxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
