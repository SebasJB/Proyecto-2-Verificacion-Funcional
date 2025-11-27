class c_121_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_121_4;
    c_121_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1z111x1xxxz01z0z011zxz10xz00x010xzzxzzxzxxzxzxxzzxzzzxxxxxxxzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
