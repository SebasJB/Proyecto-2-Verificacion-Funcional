class c_961_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 1;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_961_4;
    c_961_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "z011xzzzx1z01101100x0x0xzxxz1110xzzxzzzxzxxzxzxxxzxzzxxzxzxzxzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
