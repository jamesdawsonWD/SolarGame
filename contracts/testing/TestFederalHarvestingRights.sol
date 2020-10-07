pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {FederalHarvestingRights} from '../FederalHarvestingRights.sol';

/* solium-disable-next-line */
contract TestFederalHarvestingRights is FederalHarvestingRights {
    function testMint(address _to, uint256 _amount) public {
        _mint(_to, _amount);
    }

    constructor(address master) public FederalHarvestingRights(master) {}
}
