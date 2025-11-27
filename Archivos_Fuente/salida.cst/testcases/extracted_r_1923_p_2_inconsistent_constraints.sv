class c_1923_2;
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

program p_1923_2;
    c_1923_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "xx00x000111z0zxx10z1x1zz01xxz010xzxzzxzxxzzzxxxzzxzzxzzzzzxzxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
