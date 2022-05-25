%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

from contracts.counter.persistence import (
set_value,
get_value)
from contracts.counter.logic import (
increment_counter,
decrement_counter,
multiply_counter)
from contracts.stub_external.interface import IStubExternal

@external
func increment_by_one{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr}(
):

    let (value) = get_value()
    let (value_incremented) = increment_counter(value, 1)
    set_value(value_incremented)

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