// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Random} from './Random.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';

/**
 * @title Exchange
 * @author Big Beluga
 *
 * Library for transferring tokens and interacting with ExchangeWrappers by using the Wei struct
 */
library Army {
    using SafeMath for uint256;

    enum Units {SiegeWeapon, DefenseStructure, Soldier, Archer, Cavalry}
    struct Info {
        uint256 siegeWeapons;
        uint256 defenceStructures;
        uint256 soldiers;
        uint256 archers;
        uint256 cavalry;
        uint256 nextBattleCost;
    }
    // ============ Constants ============

    bytes32 constant FILE = 'Army';

    // ============ Library Functions ============

    function getTotalUnits(Info memory army) internal returns (uint256) {
        return
            army
                .siegeWeapons
                .add(army.defenceStructures)
                .add(army.soldiers)
                .add(army.archers)
                .add(army.cavalry);
    }

    function isDefeated(Info memory army) internal returns (bool) {
        return
            army.siegeWeapons == 0 &&
            army.defenceStructures == 0 &&
            army.archers == 0 &&
            army.cavalry == 0 &&
            army.soldiers == 0;
    }
}
