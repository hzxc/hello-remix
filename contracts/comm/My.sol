// SPDX-License-Identifier: GPL-3.0
pragma solidity ~0.8.17;

contract My {
    struct Call {
        address target;
        bytes callData;
    }

    function multiQuery(Call[] calldata calls)
        public
        view
        returns (uint256 blockNumber, bytes[] memory returnData)
    {
        blockNumber = block.number;
        returnData = new bytes[](calls.length);
        for (uint256 i = 0; i < calls.length; i++) {
            (bool success, bytes memory ret) = calls[i].target.staticcall(
                calls[i].callData
            );
            require(success);
            returnData[i] = ret;
        }
    }

    function sortTokens(address tokenA, address tokenB)
        internal
        pure
        returns (address token0, address token1)
    {
        require(tokenA != tokenB, "IDENTICAL_ADDRESSES");
        (token0, token1) = tokenA < tokenB
            ? (tokenA, tokenB)
            : (tokenB, tokenA);
        require(token0 != address(0), "ZERO_ADDRESS");
    }
}
