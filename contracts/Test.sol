// SPDX-License-Identifier: MIT

pragma solidity ~0.8.18;

contract DogechainQuickswapRouter {
    function getTimestamp() public view returns (uint256) {
        return block.timestamp;
    }

    function getBlockNum() public view returns (uint256) {
        return block.number;
    }

    function ae() public pure returns (bytes memory) {
        return
            abi.encodePacked(
                0x7B4328c127B85369D9f82ca0503B000D09CF9180,
                0xB7ddC6414bf4F5515b52D8BdD69973Ae205ff101
            );
    }
}
