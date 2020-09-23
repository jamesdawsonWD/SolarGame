// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {FundOperations} from './impl/FundOperations.sol';
import {GameOperations} from './impl/GameOperations.sol';
import {State} from './State.sol';
import {Types} from './lib/Types.sol';

/**
 * @title Operation
 * @author Big Beluga
 *
 * Primary public function for entering into the protocol
 */
contract Operations is State {
    // ============ Constants ============

    bytes32 constant FILE = 'Operation';

    function deposit(uint256 amount, uint256 length) public {
        FundOperations.deposit(g_state, amount, length);
    }

    function withdraw() public {
        FundOperations.withdraw(g_state);
    }

    function emergencyWithdraw() public {
        FundOperations.emergencyWithdraw(g_state);
    }

    // function attack(address defender) public {
    //     GameOperations.attack(g_state, msg.sender, defender);
    // }

    function move(Types.StarPosition memory from, Types.StarPosition memory to)
        public
    {
        GameOperations.move(g_state, from, to);
    }
}
