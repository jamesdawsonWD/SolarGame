pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {FederalHarvestingRights} from '../FederalHarvestingRights.sol';

/* solium-disable-next-line */
contract TestFederalHarvestingRights is FederalHarvestingRights {
    function testMint(address _to, uint256 _tokenId) public {
        _safeMint(_to, _tokenId);
    }

    constructor(address master) public FederalHarvestingRights(master) {}
}
