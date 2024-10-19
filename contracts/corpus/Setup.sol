pragma solidity =0.5.16;

import "../UniswapV2Pair.sol";
import "../UniswapV2Factory.sol";
import "../UniswapV2ERC20.sol";

contract Setup {

    UniswapV2Factory public factory;
    UniswapV2Pair public pair;
    UniswapV2ERC20 public token0;
    UniswapV2ERC20 public token1;
    User  public user;
    bool completed =false;

    constructor() public{
        factory = new UniswapV2Factory(address(this));
        token0 = new UniswapV2ERC20();
        token1 = new UniswapV2ERC20();
        address _pair = factory.createPair(address(token0), address(token1));
        pair = UniswapV2Pair(_pair);
        user = new User();

    }

    function mintToken(uint amount1, uint amount2 ) internal {
        token0.manualMint(address(user), amount1);
        token1.manualMint(address(user), amount2);
        completed = true;
    }

    function _in_between(uint _value, uint _min , uint _max) internal pure returns(uint) {
        return  _min  + (_value % _max + 1);
    }
}


contract User{
    function proxy(address _target , bytes memory  _data) public returns(bool success, bytes memory _returnData) {
        return _target.call(_data);
    }
}