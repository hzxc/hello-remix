// SPDX-License-Identifier: MIT

pragma solidity 0.8.13;

import "./libraries/SafeMath.sol";
import "./interfaces/IERC20.sol";
import "./interfaces/IPair.sol";
import "./interfaces/IPairFactory.sol";
import "./interfaces/IRouter.sol";
import "./interfaces/IWETH.sol";

contract Router is IRouter {
    using SafeMath for uint256;

    address public immutable factory =
        0x25CbdDb98b35ab1FF77413456B31EC81A6B6B746;
    bytes32 public immutable pairCodeHash =
        0xc1ac28b1c4ebe53c0cff67bab5878c4eb68759bb1e9f73977cd266b247d149f0;

    modifier ensure(uint256 deadline) {
        require(deadline >= block.timestamp, "Router: EXPIRED");
        _;
    }

    constructor() {}

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

    function sortTokens(address tokenA, address tokenB)
        public
        pure
        returns (address token0, address token1)
    {
        require(tokenA != tokenB, "Router: IDENTICAL_ADDRESSES");
        (token0, token1) = tokenA < tokenB
            ? (tokenA, tokenB)
            : (tokenB, tokenA);
        require(token0 != address(0), "Router: ZERO_ADDRESS");
    }

    function pairFor(
        address tokenA,
        address tokenB,
        bool stable
    ) public view returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            hex"ff",
                            factory,
                            keccak256(abi.encodePacked(token0, token1, stable)),
                            pairCodeHash // init code hash
                        )
                    )
                )
            )
        );
    }

    function getReserves(
        address tokenA,
        address tokenB,
        bool stable
    ) public view returns (uint256 reserveA, uint256 reserveB) {
        (address token0, ) = sortTokens(tokenA, tokenB);
        (uint256 reserve0, uint256 reserve1, ) = IPair(
            pairFor(tokenA, tokenB, stable)
        ).getReserves();
        (reserveA, reserveB) = tokenA == token0
            ? (reserve0, reserve1)
            : (reserve1, reserve0);
    }

    function isPair(address pair) external view returns (bool) {
        return IPairFactory(factory).isPair(pair);
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

    function getAmountsOut(
        uint256 amountIn,
        uint256[] memory reservesOut,
        uint256 fee
    ) public pure returns (uint256[] memory amounts) {
        require(reservesOut.length >= 2, "getAmountsOut: INVALID_PATH");
        amounts = new uint256[](reservesOut.length / 2 + 1);
        amounts[0] = amountIn;
        for (uint256 i; i < reservesOut.length / 2; i++) {
            amounts[i + 1] = getAmountOut(
                amounts[i],
                reservesOut[i * 2],
                reservesOut[i * 2 + 1],
                fee
            );
        }
    }

    function getAmountsIn(
        uint256 amountOut,
        uint256[] memory reservesIn,
        uint256 fee
    ) public pure returns (uint256[] memory amounts) {
        require(reservesIn.length >= 2, "getAmountsIn:INVALID_PATH");
        amounts = new uint256[](reservesIn.length / 2 + 1);
        amounts[amounts.length - 1] = amountOut;
        for (uint256 i = reservesIn.length / 2; i > 0; i--) {
            amounts[i - 1] = getAmountIn(
                amounts[i],
                reservesIn[i * 2 - 2],
                reservesIn[i * 2 - 1],
                fee
            );
        }
    }

    function getAmounts(
        uint8 level,
        uint256 inQty,
        uint256 outQty,
        address[] calldata pathIn,
        address[] calldata pathOut
    ) public view returns (uint256[] memory) {
        require(level >= 1, "getAmounts:INVALID_LEVEL");
        uint256[] memory amounts = new uint256[](level * 2);
        uint256 fee = IPairFactory(factory).getFee(false);

        if (inQty > 0 && pathIn.length > 1) {
            uint256[] memory reservesIn = new uint256[](
                (pathIn.length - 1) * 2
            );
            for (uint256 i = pathIn.length - 1; i > 0; i--) {
                (uint256 reserveIn, uint256 reserveOut) = getReserves(
                    pathIn[i - 1],
                    pathIn[i],
                    false
                );
                reservesIn[i * 2 - 2] = reserveIn;
                reservesIn[i * 2 - 1] = reserveOut;
            }
            for (uint8 i = 0; i < level; i++) {
                amounts[i] = getAmountsIn(inQty * (i + 1), reservesIn, fee)[0];
            }
        }

        if (outQty > 0 && pathOut.length > 1) {
            uint256[] memory reservesOut = new uint256[](
                (pathOut.length - 1) * 2
            );
            for (uint256 i; i < pathOut.length - 1; i++) {
                (uint256 reserveIn, uint256 reserveOut) = getReserves(
                    pathOut[i],
                    pathOut[i + 1],
                    false
                );

                reservesOut[i * 2] = reserveIn;
                reservesOut[i * 2 + 1] = reserveOut;
            }

            uint256[] memory outResult;
            for (uint8 i = level; i < level * 2; i++) {
                outResult = getAmountsOut(
                    outQty * (i + 1 - level),
                    reservesOut,
                    fee
                );
                amounts[i] = outResult[outResult.length - 1];
            }
        }

        return amounts;
    }
}
