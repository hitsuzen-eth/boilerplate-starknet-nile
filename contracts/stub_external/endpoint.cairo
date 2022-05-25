%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

@view
func do_nothing{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    return ()
    
end