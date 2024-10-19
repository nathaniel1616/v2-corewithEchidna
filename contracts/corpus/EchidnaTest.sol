pragma solidity =0.5.16;

import "./Setup.sol";

contract EchidnaTest  is Setup {
    function test_K_increasesWhenUserDeposits(uint amount0, uint amount1) public{
        // pre-condition
        //get the reserves

        amount0 = _in_between(amount0, 1000, uint(-1));
        amount1 = _in_between(amount1, 1000, uint(-1));

        if (! completed) {
            mintToken(amount0, amount1);
        }

        uint lpTokenBalanceOfUserBefore = pair.balanceOf(address(user));

        (uint token0ReservesBefore, uint token1ReserVersBefore,) = pair.getReserves();
        uint k_before = token0ReservesBefore * token1ReserVersBefore;


        // action
        // user makes a deposit into the pair 
        // transfer  token 0 and token 1 to the pair
        
     
        
        (bool success1, )=user.proxy(address(token0),abi.encodeWithSelector( token0.transfer.selector, address(pair), amount0)); 
        (bool success2, )=user.proxy(address(token1),abi.encodeWithSelector( token1.transfer.selector, address(pair), amount1));
        require(success1 && success2);     

        
       (bool success3, ) = user.proxy(address(pair),abi.encodeWithSelector( pair.mint.selector, address(pair), address(user)));


        // post-condition

        if (success3) {
            
        (uint token0ReserveAfter, uint token1ReserVeresAfer,) = pair.getReserves();
        uint lpTokenBalanceOfUserAfter = pair.balanceOf(address(user));
        uint k_after = token0ReserveAfter * token1ReserVeresAfer;

        assert ( token0ReserveAfter > token0ReservesBefore);
        assert (k_after > k_before);
        assert (lpTokenBalanceOfUserAfter > lpTokenBalanceOfUserBefore);
        }
        

    }
}