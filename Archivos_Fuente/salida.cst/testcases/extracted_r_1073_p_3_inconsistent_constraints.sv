class c_1073_3;
    bit[7:0] pkt_id = 8'h0;

    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:78)
    {
       (pkt_id == 8'hde);
    }
endclass

program p_1073_3;
    c_1073_3 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1z11x110zxz10101zz001z01x01zxx1zzxxxxxxxxxzzxzxxzzxzzzxzzxxxxzzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
