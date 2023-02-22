// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ~0.8.17;

interface IPair {
    function tokens() external returns (address, address);

    function getReserves()
        external
        view
        returns (
            uint256 _reserve0,
            uint256 _reserve1,
            uint256 _blockTimestampLast
        );
}
