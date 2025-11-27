class c_1018_2;
    bit[4:0] src_id = 5'h0;
    bit[31:0] targets_2_ = 32'h0;
    rand bit[31:0] dest_addr; // rand_mode = ON 

    constraint c_dest_addr_this    // (constraint_mode = ON) (TypesandTransactions.sv:116)
    {
       (dest_addr != src_id);
    }
    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (dest_addr == targets_2_);
    }
endclass

program p_1018_2;
    c_1018_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx1zx01z0z1z10xz10zz10x0xzzzx111xzzxzxxzzzzzzxxzzzxzxzxxzxzzzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
