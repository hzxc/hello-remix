// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ~0.8.17;

interface IPairFactory {
    function feeRate() external view returns (uint256);

    function getFee() external view returns (uint256);

    function getFee(bool stable) external view returns (uint256);

    function allPairsLength() external view returns (uint256);

    function isPair(address pair) external view returns (bool);

    function pairCodeHash() external pure returns (bytes32);

    function getPair(
        address tokenA,
        address token,
        bool stable
    ) external view returns (address);

    function createPair(
        address tokenA,
        address tokenB,
        bool stable
    ) external returns (address pair);
}
