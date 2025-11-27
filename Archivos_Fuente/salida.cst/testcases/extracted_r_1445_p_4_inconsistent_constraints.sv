class c_1445_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 3;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_1445_4;
    c_1445_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0x11x1z010zxzx10x1z10xzx0111x00xzzzxzzxzzzzxxzzzzzzzzxxxzzzxxxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
