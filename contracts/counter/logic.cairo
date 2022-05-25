%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import (
assert_nn,
assert_le)

from contracts.services.operation import (
multiply,
plus,
minus)

@view
func increment_counter{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _value: felt, _to_add: felt) -> (value_new: felt):

    assert_nn(_to_add)

    let (value_new) = plus(_value, _to_add)

    return (value_new)
    
end

@view
func decrement_counter{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _value: felt, _to_remove: felt) -> (value_new: felt):

    assert_nn(_to_remove)
    assert_le(_to_remove, _value)

    let (value_new) = minus(_value, _to_remove)

    return (value_new)
    
end

@view
func multiply_counter{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _value: felt, _multiplier: felt) -> (value_new: felt):

    assert_nn(_multiplier)

    let (value_new) = multiply(_value, _multiplier)

    return (value_new)
    
end