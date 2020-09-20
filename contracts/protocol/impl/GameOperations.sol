// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Events} from '../lib/Events.sol';
import {Storage} from '../lib/Storage.sol';
import {ITsuno} from '../interfaces/ITsuno.sol';
import {Battle} from '../lib/Battle.sol';
import {Army} from '../lib/Army.sol';

/**
 * @title Operation
 * @author Big Beluga
 *
 * Primary public function for entering into the protocol
 */
library GameOperations {
    using SafeMath for uint256;
    using Storage for Storage.State;

    // ============ Constants ============

    bytes32 constant FILE = 'GameOperations';

    function attack(
        Storage.State storage state,
        address attacker,
        address defender
    ) public {
        // Get the armies
        Army.Info memory attackerArmy = Storage.getArmy(state, attacker);
        Army.Info memory defenderArmy = Storage.getArmy(state, defender);

        // TODO: convert string array to bytes32 array
        // true = attackers, false = defenders
        (bool result, bytes memory log) = Battle.attack(
            attackerArmy,
            defenderArmy
        );

        if (result) {
            uint256 reward = Storage.getBalance(state, defender).div(100).mul(
                80
            );
            Storage.addBalance(state, attacker, reward);
            Storage.subBalance(state, defender, reward);
        } else {
            uint256 reward = Storage.getBalance(state, attacker).div(100).mul(
                40
            );
            Storage.addBalance(state, defender, reward);
            Storage.subBalance(state, attacker, reward);
        }

        Events.logBattle(attacker, defender, result, string(log));
    }
}
