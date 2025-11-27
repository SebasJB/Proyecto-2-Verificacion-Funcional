class c_1868_2;
    bit[4:0] src_id = 5'h0;
    bit[31:0] targets_0_ = 32'h0;
    rand bit[31:0] dest_addr; // rand_mode = ON 

    constraint c_dest_addr_this    // (constraint_mode = ON) (TypesandTransactions.sv:116)
    {
       (dest_addr != src_id);
    }
    constraint WITH_CONSTRAINT_this    // (constraint_mode = ON) (Secuencer.sv:60)
    {
       (dest_addr == targets_0_);
    }
endclass

program p_1868_2;
    c_1868_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "011x01110xxz0x11x1xx0z0zz00x0x0xxzxzzxxzxxxxxxzzzzzzzxxxxzxzzxzx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
