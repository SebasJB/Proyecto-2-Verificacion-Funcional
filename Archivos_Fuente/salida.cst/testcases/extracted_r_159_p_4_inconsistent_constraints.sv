class c_159_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_159_4;
    c_159_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "10x01z00100xz1100zxz1xxxx11x0x00zxzxxxzxxxzxxzzzzxxxxzzxzzzxzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
