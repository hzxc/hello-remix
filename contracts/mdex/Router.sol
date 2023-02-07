pragma solidity =0.6.6;

import "./Ownable.sol";

import "./interfaces/IMdexFactory.sol";
import "./interfaces/IMdexRouter.sol";
import "./interfaces/IWHT.sol";
// import "./interfaces/IMdexPair.sol";
// import "./interfaces/IERC20.sol";
// import "./interfaces/ISwapMining.sol";

import "./libraries/SafeMath.sol";
import "./libraries/TransferHelper.sol";

contract MdexRouter is IMdexRouter, Ownable {
    using SafeMath for uint256;

    address public immutable override factory =
        0xb0b670fc1F7724119963018DB0BfA86aDb22d941;
    address public immutable override WHT =
        0x5545153CCFcA01fbd7Dd11C0b23ba694D9509A6F;

    modifier ensure(uint256 deadline) {
        require(deadline >= block.timestamp, "MdexRouter: EXPIRED");
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

    function deposit(address token, uint256 amounts) public {
        TransferHelper.safeTransferFrom(
            token,
            msg.sender,
            address(this),
            amounts
        );
    }

    function depositWETH() public payable onlyOwner {
        require(msg.value > 0, "depositWETH: INVALID_VALUE");
        IWHT(WHT).deposit{value: msg.value}();
    }

    function withdraw(address token, uint256 amounts) public onlyOwner {
        TransferHelper.safeTransferFrom(
            token,
            address(this),
            msg.sender,
            amounts
        );
    }

    function approve(
        address token,
        address to,
        uint256 val
    ) public onlyOwner returns (bool) {
        val = val > 0 ? val : uint256(-1);
        TransferHelper.safeApprove(token, to, val);
    }

    // **** LIBRARY FUNCTIONS ****

    function getAmountsOut(uint256 amountIn, address[] memory path)
        public
        view
        override
        returns (uint256[] memory amounts)
    {
        return IMdexFactory(factory).getAmountsOut(amountIn, path);
    }

    function getAmountsIn(uint256 amountOut, address[] memory path)
        public
        view
        override
        returns (uint256[] memory amounts)
    {
        return IMdexFactory(factory).getAmountsIn(amountOut, path);
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
                amounts[i] = getAmountsIn(inQty**(i + 1), inPath)[0];
            }
        }
        if (outQty > 0) {
            uint256[] memory outResult;
            for (uint8 i = level; i < level * 2; i++) {
                outResult = getAmountsOut(outQty**(i - 3), outPath);
                amounts[i] = outResult[outResult.length - 1];
            }
        }

        return amounts;
    }
}
