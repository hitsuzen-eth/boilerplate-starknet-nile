%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import assert_nn

from contracts.services.operation import (
multiply,
plus)

@view
func increment{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
    _value: felt, _to_add: felt) -> (value_new: felt):

    assert_nn(_to_add)

    let (value_new) = plus(_value, _to_add)

    return (value_new)
    
end