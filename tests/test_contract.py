import os

import pytest
from starkware.starknet.testing.starknet import Starknet

COUNTER = os.path.join("contracts", "counter", "endpoint.cairo")
STUB_EXTERNAL = os.path.join("contracts", "stub_external", "endpoint.cairo")


@pytest.mark.asyncio
async def test_increment_counter():
    starknet = await Starknet.empty()

    counter = await starknet.deploy(
        source=COUNTER,
    )

    execution_info = await counter.get_counter_value().call()
    assert execution_info.result == (0,)

    await counter.increment_by_one().invoke()

    execution_info = await counter.get_counter_value().call()
    assert execution_info.result == (1,)

    await counter.increment_by_one().invoke()
    await counter.increment_by_one().invoke()

    execution_info = await counter.get_counter_value().call()
    assert execution_info.result == (3,)

@pytest.mark.asyncio
async def test_decrement_counter():
    starknet = await Starknet.empty()

    counter = await starknet.deploy(
        source=COUNTER,
    )

    execution_info = await counter.get_counter_value().call()
    assert execution_info.result == (0,)
    
    with pytest.raises(Exception):
        await counter.decrement_by_one().invoke()

    await counter.increment_by_one().invoke()
    await counter.increment_by_one().invoke()
    await counter.decrement_by_one().invoke()

    execution_info = await counter.get_counter_value().call()
    assert execution_info.result == (1,)

    await counter.increment_by_one().invoke()
    await counter.decrement_by_one().invoke()
    await counter.decrement_by_one().invoke()

    execution_info = await counter.get_counter_value().call()
    assert execution_info.result == (0,)

@pytest.mark.asyncio
async def test_double_effect_counter():
    starknet = await Starknet.empty()

    counter = await starknet.deploy(
        source=COUNTER,
    )

    stub_external = await starknet.deploy(
        source=STUB_EXTERNAL,
    )

    execution_info = await counter.get_counter_value().call()
    assert execution_info.result == (0,)

    await counter.double_effect(stub_external.contract_address).invoke()

    execution_info = await counter.get_counter_value().call()
    assert execution_info.result == (0,)

    await counter.increment_by_one().invoke()
    await counter.double_effect(stub_external.contract_address).invoke()

    execution_info = await counter.get_counter_value().call()
    assert execution_info.result == (2,)

    await counter.double_effect(stub_external.contract_address).invoke()
    await counter.double_effect(stub_external.contract_address).invoke()

    execution_info = await counter.get_counter_value().call()
    assert execution_info.result == (8,)
