%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

@storage_var
func value() -> (res : felt):
end

@constructor
func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}():
    set_value(0)

    return()
end

@external
func set_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _value : felt):

    value.write(_value)
    let (value_new) = value.read()
    
    return ()
end

@external
func add_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _value : felt):

    let (value_old) = value.read()
    value.write(value_old + _value)
    let (value_new) = value.read()
    
    return ()
end

@view
func get_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
) -> (value_now : felt):

    let (value_now) = value.read()
    return (value_now)
end