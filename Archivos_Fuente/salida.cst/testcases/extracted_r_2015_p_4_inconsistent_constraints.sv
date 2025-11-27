class c_2015_4;
    bit[4:0] src_id = 5'h0;
    bit[31:0] seq_id = 32'h1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:95)
    {
       (src_id == seq_id);
    }
endclass

program p_2015_4;
    c_2015_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zxzz1xz00zx1x01z101x00zx1xzx11xxzzzxzxxzxzzzxzxzxzzzzxzxzzxzxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
