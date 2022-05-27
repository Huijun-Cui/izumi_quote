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
        uint128 direction;
        uint128 fee;
        address pair;
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
    
    function get_reserves(address pair) public view returns(uint reserveA, uint reserveB) {
        (uint reserve0, uint reserve1,) = IPair(pair).getReserves();
        (reserveA, reserveB) = (reserve0, reserve1);
    }

    function izumi_swap(address addr,uint128 amount,bytes calldata path)  public returns(uint256) {
        (uint256 ret,) = IzumiQuote(addr).swapAmount(amount, path);
        return ret;
    }

}