// SPDX-License-Identifier: GPL-3.0
pragma solidity ~0.8.17;

contract Encode {
    function testFunc() external view returns (uint256, uint256) {
        return (1, block.timestamp);
    }

    function getData() external pure returns (bytes memory) {
        return abi.encodeWithSelector(this.testFunc.selector);
    }

    function getData(string calldata name) external pure returns (bytes memory) {
        // "swapExactTokensForTokens(uint256,uint256,address[],address)" return "0x472b43f3"
        // "multicall(bytes32,bytes[])" return "0x1f0464d1"
        // "approveMax(address)" return return "0x571ac8b0"
        // "aggregate((address,bytes)[])" return "0x252dba42"
        return abi.encodeWithSignature(name);
    }
}
