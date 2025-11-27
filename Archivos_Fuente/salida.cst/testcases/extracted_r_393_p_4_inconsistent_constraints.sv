class c_393_4;
    bit[31:0] seq_id = 32'hf;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_393_4;
    c_393_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "101z0zx0x111zx1xz1000x110x1zzxxzzxxxzzzxzxxzxxxzxxxxxxxzxxxzzzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
