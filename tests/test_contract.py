"""contract.cairo test file."""
import os

import pytest
from starkware.starknet.testing.starknet import Starknet

# The path to the contract source code.
COUNTER = os.path.join("contracts", "endpoints", "counters", "counter.cairo")


# The testing library uses python's asyncio. So the following
# decorator and the ``async`` keyword are needed.
@pytest.mark.asyncio
async def test_increase_balance():
    """Test increase_balance method."""
    # Create a new Starknet class that simulates the StarkNet
    # system.
    starknet = await Starknet.empty()

    # Deploy the contract.
    contract = await starknet.deploy(
        source=COUNTER,
    )

    # Invoke increase_balance() twice.
    await contract.increment_by_one().invoke()

    # Check the result of get_balance().
    execution_info = await contract.get_counter_value().call()
    assert execution_info.result == (1,)

    # Invoke increase_balance() twice.
    await contract.increment_by_one().invoke()

    # Check the result of get_balance().
    execution_info = await contract.get_counter_value().call()
    assert execution_info.result == (2,)
