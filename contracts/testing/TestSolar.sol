pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SolarToken} from '../SolarToken.sol';

/* solium-disable-next-line */
contract TestSolar is SolarToken {
    constructor(address eternalStorage) public SolarToken(eternalStorage) {}

    function testMint(address _to, uint256 _amount) public {
        _mint(_to, _amount);
    }
}
