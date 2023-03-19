// SPDX-License-Identifier: MIT

pragma solidity ~0.8.17;

import "./interfaces/IERC20.sol";
import "./libraries/SafeMath.sol";
import "./interfaces/IPair.sol";
import "./interfaces/IPairFactory.sol";

contract Query {
    using SafeMath for uint256;
    address public immutable factory =
        0x25CbdDb98b35ab1FF77413456B31EC81A6B6B746;
    bytes32 public immutable pairCodeHash =
        0xc1ac28b1c4ebe53c0cff67bab5878c4eb68759bb1e9f73977cd266b247d149f0;

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

    function sortTokens(
        address tknA,
        address tknB
    ) public pure returns (address tkn0, address tkn1) {
        require(tknA != tknB, "Router: IDENTICAL_ADDRESSES");
        (tkn0, tkn1) = tknA < tknB ? (tknA, tknB) : (tknB, tknA);
        require(tkn0 != address(0), "Router: ZERO_ADDRESS");
    }

    function pairFor(
        address tknA,
        address tknB
    ) public view returns (address pair) {
        (address tkn0, address tkn1) = sortTokens(tknA, tknB);
        pair = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            hex"ff",
                            factory,
                            keccak256(abi.encodePacked(tkn0, tkn1, false)),
                            pairCodeHash
                        )
                    )
                )
            )
        );
    }

    function getReserves(
        address tokenA,
        address tokenB
    ) public view returns (uint256 reserveA, uint256 reserveB) {
        (address token0, ) = sortTokens(tokenA, tokenB);
        (uint256 reserve0, uint256 reserve1, ) = IPair(pairFor(tokenA, tokenB))
            .getReserves();
        (reserveA, reserveB) = tokenA == token0
            ? (reserve0, reserve1)
            : (reserve1, reserve0);
    }

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut,
        uint256 fee
    ) public pure returns (uint256 amountIn) {
        require(amountOut > 0, "getAmountIn: INSUFFICIENT_OUTPUT_AMOUNT");
        require(
            reserveIn > 0 && reserveOut > 0,
            "getAmountIn: INSUFFICIENT_LIQUIDITY"
        );
        uint256 numerator = reserveIn.mul(amountOut).mul(10000);
        uint256 denominator = reserveOut.sub(amountOut).mul(10000 - fee);

        amountIn = (numerator / denominator).add(1);
    }

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut,
        uint256 fee
    ) public pure returns (uint256 amountOut) {
        require(amountIn > 0, "getAmountOut: INSUFFICIENT_INPUT_AMOUNT");
        require(
            reserveIn > 0 && reserveOut > 0,
            "getAmountOut: INSUFFICIENT_LIQUIDITY"
        );
        uint256 amountInWithFee = amountIn.mul(10000 - fee);
        uint256 numerator = amountInWithFee.mul(reserveOut);
        uint256 denominator = reserveIn.mul(10000).add(amountInWithFee);

        amountOut = numerator / denominator;
    }

    function getAmountsIn(
        uint256 amountOut,
        address[] memory path,
        uint256 fee
    ) public view returns (uint256[] memory amounts) {
        require(path.length >= 2, "getAmountsIn: INVALID_PATH");
        amounts = new uint256[](path.length);
        amounts[amounts.length - 1] = amountOut;
        for (uint256 i = path.length - 1; i > 0; i--) {
            (uint256 reserveIn, uint256 reserveOut) = getReserves(
                path[i - 1],
                path[i]
            );
            amounts[i - 1] = getAmountIn(
                amounts[i],
                reserveIn,
                reserveOut,
                fee
            );
        }
    }

    function getAmountsOut(
        uint256 amountIn,
        address[] memory path,
        uint256 fee
    ) public view returns (uint256[] memory amounts) {
        require(path.length >= 2, "getAmountsOut: INVALID_PATH");
        amounts = new uint256[](path.length);
        amounts[0] = amountIn;
        for (uint256 i; i < path.length - 1; i++) {
            (uint256 reserveIn, uint256 reserveOut) = getReserves(
                path[i],
                path[i + 1]
            );
            amounts[i + 1] = getAmountOut(
                amounts[i],
                reserveIn,
                reserveOut,
                fee
            );
        }
    }

    function getAmounts(
        uint8 level,
        uint256 inQty,
        uint256 outQty,
        address[] memory inPath,
        address[] memory outPath
    ) public view returns (uint256[] memory, uint256) {
        uint256[] memory amounts = new uint256[](level * 2);
        uint256 fee = IPairFactory(factory).getFee(false);
        if (inQty > 0) {
            for (uint8 i = 0; i < level; i++) {
                amounts[i] = getAmountsIn(inQty * (i + 1), inPath, fee)[0];
            }
        }
        if (outQty > 0) {
            uint256[] memory outResult;
            for (uint8 i = level; i < level * 2; i++) {
                outResult = getAmountsOut(
                    outQty * (i + 1 - level),
                    outPath,
                    fee
                );
                amounts[i] = outResult[outResult.length - 1];
            }
        }

        return (amounts, block.number);
    }
}
