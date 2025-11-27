class c_404_4;
    bit[31:0] seq_id = 32'h4;
    bit[7:0] pkt_id = 8'h0;
    integer t = 0;
    integer mm = 0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (pkt_id == (((16 * seq_id) + (t * 2)) + mm));
    }
endclass

program p_404_4;
    c_404_4 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0z00xzxz0z001000xz10z00x11xz1xzxzxzxzxxzzxxxzxzxxxxzxzxzxxxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
