// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {TsunoToken} from '../protocol/TsunoToken.sol';

/* solium-disable-next-line */
contract TestTsuno is TsunoToken {
    constructor(address[] memory testAccounts) public {
        for (uint256 i = 0; i < testAccounts.length; i++) {
            _mint(testAccounts[i], 100000);
        }
    }

    function testMint(address _to, uint256 _amount) public {
        _mint(_to, _amount);
    }
}
