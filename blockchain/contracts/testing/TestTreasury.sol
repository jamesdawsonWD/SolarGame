pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Treasury} from '../Treasury.sol';

/* solium-disable-next-line */
contract TestTreasury is Treasury {
    function testMintSolar(address _to, uint256 _amount) public {
        solar.mint(_to, _amount);
    }

    function testSendSats(
        address _to,
        uint256[] memory _ids,
        uint256[] memory _amounts
    ) public {
        sats.safeBatchTransferFrom(address(this), _to, _ids, _amounts, '');
    }
}
