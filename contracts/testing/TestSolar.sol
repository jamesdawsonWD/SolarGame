pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SolarToken} from '../protocol/SolarToken.sol';

/* solium-disable-next-line */
contract TestSolar is SolarToken {
    constructor(address master) public SolarToken(master) {}

    function testMint(address _to, uint256 _amount) public {
        _mint(_to, _amount);
    }
}
