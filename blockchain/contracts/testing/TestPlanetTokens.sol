pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Planets} from '../Planets.sol';

/* solium-disable-next-line */
contract TestPlanets is Planets {
    function testMint(address _to, uint256 _tokenId) public {
        _safeMint(_to, _tokenId);
    }

    constructor(address master) public Planets(master) {}
}
