// SPDX-License-Identifier: MIT

pragma solidity ~0.8.17;
import "./interfaces/IQuoter.sol";
import "./interfaces/IERC20.sol";
import "./libraries/SafeMath.sol";

contract Query {
    using SafeMath for uint256;
    address public immutable quoter =
        0xd8E1E7009802c914b0d39B31Fc1759A865b727B1;

    function quote(
        uint8 lv,
        uint256 buyQty,
        bytes calldata buyPath,
        uint256 sellQty,
        bytes calldata sellPath
    ) external returns (uint256[] memory) {
        uint256[] memory amounts = new uint256[](lv * 2);

        if (buyQty > 0) {
            for (uint8 i = 0; i < lv; i++) {
                (amounts[i], ) = IQuoter(quoter).quoteExactOutput(
                    buyPath,
                    buyQty.mul(i + 1)
                );
            }
        }

        if (sellQty > 0) {
            for (uint8 i = lv; i < lv * 2; i++) {
                (amounts[i], ) = IQuoter(quoter).quoteExactInput(
                    sellPath,
                    sellQty.mul(i + 1 - lv)
                );
            }
        }

        return amounts;
    }

    function getTimestamp() public view returns (uint256) {
        return block.timestamp;
    }

    function getBlockNum() public view returns (uint256) {
        return block.number;
    }

    function getBal(address token, address act) public view returns (uint256) {
        return IERC20(token).balanceOf(act);
    }

    function getBals(
        address[] memory tokens,
        address act
    ) public view returns (uint256[] memory) {
        uint256[] memory bals = new uint256[](tokens.length);
        for (uint8 i = 0; i < tokens.length; i++) {
            bals[i] = IERC20(tokens[i]).balanceOf(act);
        }

        return bals;
    }
}
