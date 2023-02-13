pragma solidity =0.6.6;

import "./Ownable.sol";

import "./interfaces/IUniswapV2Factory.sol";
import "./interfaces/IUniswapV2Router.sol";
import "./interfaces/IWETH.sol";
import "./interfaces/IERC20.sol";

import "./libraries/SafeMath.sol";
import "./libraries/TransferHelper.sol";
import "./libraries/UniswapV2Library.sol";

contract UniswapV2Router is IUniswapV2Router, Ownable {
    using SafeMath for uint256;

    address public immutable override factory =
        0x5757371414417b8C6CAad45bAeF941aBc7d3Ab32;
    address public immutable override WETH =
        0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270;

    modifier ensure(uint256 deadline) {
        require(deadline >= block.timestamp, "UniswapV2Router: EXPIRED");
        _;
    }

    constructor() public {}

    receive() external payable {}

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

    function deposit(address token, uint256 amounts) public {
        TransferHelper.safeTransferFrom(
            token,
            msg.sender,
            address(this),
            amounts
        );
    }

    function depositWETH() public payable {
        require(msg.value > 0, "depositWETH: INVALID_VALUE");
        IWETH(WETH).deposit{value: msg.value}();
    }

    function withdraw(address token, uint256 amounts) public onlyOwner {
        TransferHelper.safeTransferFrom(
            token,
            address(this),
            msg.sender,
            amounts
        );
    }

    function withdrawETH(uint256 amounts) public onlyOwner {
        TransferHelper.safeTransferETH(msg.sender, amounts);
    }

    function approve(
        address token,
        address to,
        uint256 val
    ) public returns (bool) {
        val = val > 0 ? val : uint256(-1);
        TransferHelper.safeApprove(token, to, val);
    }

    // **** LIBRARY FUNCTIONS ****
    function getAmountsOut(uint256 amountIn, address[] memory path)
        public
        view
        virtual
        override
        returns (uint256[] memory amounts)
    {
        return UniswapV2Library.getAmountsOut(factory, amountIn, path);
    }

    function getAmountsIn(uint256 amountOut, address[] memory path)
        public
        view
        virtual
        override
        returns (uint256[] memory amounts)
    {
        return UniswapV2Library.getAmountsIn(factory, amountOut, path);
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
                amounts[i] = getAmountsIn(inQty * (i + 1), inPath)[0];
            }
        }
        if (outQty > 0) {
            uint256[] memory outResult;
            for (uint8 i = level; i < level * 2; i++) {
                outResult = getAmountsOut(outQty * (i + 1 - level), outPath);
                amounts[i] = outResult[outResult.length - 1];
            }
        }

        return amounts;
    }
}
