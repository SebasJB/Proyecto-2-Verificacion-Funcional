class c_481_2;
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

program p_481_2;
    c_481_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "1xx10z1z0x1zx11zz10xz0000z0xxx00xzzzxzzzzxzzzzxxzzxxzxzxzzxxzzzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
