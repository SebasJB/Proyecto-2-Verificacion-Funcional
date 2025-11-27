class c_509_2;
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

program p_509_2;
    c_509_2 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zx01x00z01xx1xz1z0zz10x011x0xz0zxxxzzzxxzxzxzxxxxxzxzxxzzxxxxzxx";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
