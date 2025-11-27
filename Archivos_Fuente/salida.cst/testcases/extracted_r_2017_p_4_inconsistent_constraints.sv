class c_2017_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h3;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_2017_4;
    c_2017_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zxx1xxxzzzx01zx1x10z00011x0z11xzzzxxxxzzzxzzzzxxxzzzzzzzzzzzzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
