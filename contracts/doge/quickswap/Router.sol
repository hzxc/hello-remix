// SPDX-License-Identifier: MIT

pragma solidity ~0.8.18;

import "./interfaces/IERC20.sol";
import "./interfaces/IRouter.sol";

import "./libraries/SafeMath.sol";

contract DogechainQuickswapRouter {
    using SafeMath for uint256;

    address public immutable router =
        0x4aE2bD0666c76C7f39311b9B3e39b53C8D7C43Ea;

    function getTimestamp() public view returns (uint256) {
        return block.timestamp;
    }

    function getBlockNum() public view returns (uint256) {
        return block.number;
    }

    function getBal(address token, address act) public view returns (uint256) {
        return IERC20(token).balanceOf(act);
    }

    function getBals(address[] memory tokens, address act)
        public
        view
        returns (uint256[] memory)
    {
        uint256[] memory bals = new uint256[](tokens.length);
        for (uint8 i = 0; i < tokens.length; i++) {
            bals[i] = IERC20(tokens[i]).balanceOf(act);
        }

        return bals;
    }

    function getAmounts(
        uint8 level,
        uint256 inQty,
        uint256 outQty,
        address[] memory inPath,
        address[] memory outPath
    ) public view returns (uint256[] memory) {
        uint256[] memory amounts = new uint256[](level * 2);

        if (inQty > 0) {
            for (uint8 i = 0; i < level; i++) {
                amounts[i] = IRouter(router).getAmountsIn(
                    inQty * (i + 1),
                    inPath
                )[0];
            }
        }
        if (outQty > 0) {
            uint256[] memory outResult;
            for (uint8 i = level; i < level * 2; i++) {
                outResult = IRouter(router).getAmountsOut(
                    outQty * (i + 1 - level),
                    outPath
                );
                amounts[i] = outResult[outResult.length - 1];
            }
        }

        return amounts;
    }
}
