%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

from contracts.persistences.counters.counter import (
set_value,
get_value)
from contracts.businesses.counters.counter import (
increment_counter,
decrement_counter,
multiply_counter)
from contracts.endpoints.stub_externals.stub_external_interface import IStubExternal

@external
func increment_by_one{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
):

    let (value) = get_value()
    let (value_incremented) = increment_counter(value, 1)
    set_value(value_incremented)
    value_incremented = value_incremented + 1
    # Now get_counter_value() will return +2 instead of +1

    return ()
end

@external
func decrement_by_one{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
):

    let (value) = get_value()
    let (value_decremented) = decrement_counter(value, 1)
    set_value(value_decremented)

    return ()
end


@external
func double_effect{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
contract_address: felt):

    IStubExternal.do_nothing(contract_address=contract_address)

    let (value) = get_value()
    let (value_doubled) = multiply_counter(value, 2)
    set_value(value_doubled)

    return ()
end

@view
func get_counter_value{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
) -> (value: felt):

    let (value) = get_value()

    return (value)
end