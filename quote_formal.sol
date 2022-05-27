pragma solidity >=0.6.0;


library SafeMath {
    function add(uint x, uint y) internal pure returns (uint z) {
        require((z = x + y) >= x, 'ds-math-add-overflow');
    }

    function sub(uint x, uint y) internal pure returns (uint z) {
        require((z = x - y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');
    }
}


interface IPair {
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function token0() external view returns (address);
}

interface IzumiQuote {
    function swapAmount(uint128,bytes calldata path) external returns (uint256 acquire, int24[] memory pointAfterList);
}

// interface Factory {

// }

contract PriceQuote {
    using SafeMath for uint256;
    struct Params {
        bytes path;
        address pair;
        uint128 direction;
        uint128 fee;
    }

    address payable public _owner;
    
    mapping(address => mapping(address => bytes)) private _pool;
    mapping(address => mapping(address => mapping(address => bytes))) private _pool2;
    constructor() public {
        _owner = payable(msg.sender);
    }
    modifier onlyOwner() {
        require(_owner == msg.sender, 'Ownable: caller is not the owner');
        _;
    }
    
    function getAmountOut(uint256 amountIn, uint256 reserveIn, uint256 reserveOut,uint fee) internal pure returns (uint256 amountOut) {
        require(amountIn > 0, 'PancakeLibrary: INSUFFICIENT_INPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'PancakeLibrary: INSUFFICIENT_LIQUIDITY');
        uint amountInWithFee = amountIn.mul(10000 - fee);
        uint numerator = amountInWithFee.mul(reserveOut);
        uint denominator = reserveIn.mul(10000).add(amountInWithFee);
        amountOut = numerator / denominator;
    }
    
    function get_reserves(address pair) public view returns(uint reserveA, uint reserveB) {
        (uint reserve0, uint reserve1,) = IPair(pair).getReserves();
        (reserveA, reserveB) = (reserve0, reserve1);
    }

    function izumi_swap(address addr,uint128 amount,bytes calldata path)  public returns(uint256) {
        (uint256 ret,) = IzumiQuote(addr).swapAmount(amount, path);
        return ret;
    }

    function multi_swap(address izumi_quote,uint128 amount,bytes[] calldata paths,address[] calldata pairs,uint128[] calldata directions,uint[] calldata fees) public returns (uint256[] memory) {
        uint256[] memory amount_rets = new uint256[](paths.length);
        uint256 amount3;
        for (uint256 i = 0; i < paths.length; i++) {

            uint256 amount2 = izumi_swap(izumi_quote,amount,paths[i]);
            (uint reserve0, uint reserve1) = get_reserves(pairs[i]);
            if (directions[i] == 0) {
                amount_rets[i] = getAmountOut(amount2,reserve0,reserve1,fees[i]);
            } else {
                amount_rets[i] = getAmountOut(amount2,reserve1,reserve0,fees[i]);
            }
        }
        return amount_rets;
    }

    

}