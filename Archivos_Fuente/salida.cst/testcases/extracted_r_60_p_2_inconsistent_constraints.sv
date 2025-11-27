class c_60_2;
    bit[4:0] src_id = 5'h0;
    bit[31:0] targets_1_ = 32'h0;
    rand bit[31:0] dest_addr; // rand_mode = ON 

    constraint c_dest_addr_this    // (constraint_mode = ON) (TypesandTransactions.sv:116)
    {
       (dest_addr != src_id);
    }
    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (dest_addr == targets_1_);
    }
endclass

program p_60_2;
    c_60_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "x0xz1xx011zx1xx0xxzx0x10x1100x10xzxxzxxzzzxxzzxzxzxxxzzxxzxxzzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
