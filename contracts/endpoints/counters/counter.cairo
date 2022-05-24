%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

from contracts.persistences.counters.counter import (
set_value,
get_value)
from contracts.businesses.counters.counter import (
increment)

@external
func increment_by_one{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
):

    let (value) = get_value()
    let (value_incremented) = increment(value, 1)
    set_value(value_incremented)

    return ()
end

@view
func get_counter_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
) -> (value: felt):

    let (value) = get_value()

    return (value)
end