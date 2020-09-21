pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {TsunoToken} from '../protocol/TsunoToken.sol';

/* solium-disable-next-line */
contract TestTsuno is TsunoToken {
    function testMint(address _to, uint256 _amount) public {
        _mint(_to, _amount);
    }
}
