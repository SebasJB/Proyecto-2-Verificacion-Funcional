class c_410_4;
    bit[31:0] seq_id = 32'h1;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_410_4;
    c_410_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1xx110xz11001xx11xx010z10xx0z01xxxzzzxxxzzzxzzzxzzxzzxzzzzzxxxxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
