class c_1046_2;
    bit[4:0] src_id = 5'h0;
    bit[31:0] targets_3_ = 32'h0;
    rand bit[31:0] dest_addr; // rand_mode = ON 

    constraint c_dest_addr_this    // (constraint_mode = ON) (TypesandTransactions.sv:116)
    {
       (dest_addr != src_id);
    }
    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (dest_addr == targets_3_);
    }
endclass

program p_1046_2;
    c_1046_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "110x0zx1110xz001z011x11xxxz10111zxxxxzzxxxxxzzzzxxzzzzxxxxzxxxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
