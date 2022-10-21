// SPDX-License-Identifier: GPL-3.0
pragma solidity ~0.8.17;

contract MultiQuery {
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
}
