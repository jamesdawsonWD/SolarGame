// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Random} from './Random.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Fleet} from './Fleet.sol';

/**
 * @title Star System
 * @author Jim Dawson
 *
 * Library for transferring tokens and interacting with ExchangeWrappers by using the Wei struct
 */
library StarSystem {
    using SafeMath for uint256;

    uint32 constant LOW_YIELD_LOW = 1;
    uint32 constant LOW_YIELD_HIGH = 75;
    uint32 constant MEDIUM_YIELD_LOW = 76;
    uint32 constant MEDIUM_YIELD_HIGH = 150;
    uint32 constant HIGH_YIELD_LOW = 151;
    uint32 constant HIGH_YIELD_HIGH = 400;
    uint32 constant INSANE_YIELD_LOW = 401;
    uint32 constant INSANE_YIELD_HIGH = 1000;
    uint256 constant TOTAL_SYSTEM_TYPES = 7;

    enum SystemType {
        Undiscovered,
        Empty,
        GovermentOwned,
        // Uninhabitable,
        // ShipWreck,
        // BlackMarket,
        // RegularMarket,
        LowYieldSystem,
        MediumYieldSystem,
        HighYieldSystem,
        InsaneYieldSystem,
        // AlienMarket,
        // AlienPassive,
        // AlienAggressive,
        // PirateOwned,
        // AdvancedRaceMarket,
        // AdvancedRacePassive,
        // AdvancedRaceAggressive,
        // EretheumMiningSystem,
        // AncientMiningSystem,
        // AncientWeaponSystem,
        AncientShipWreck
    }
    struct Info {
        SystemType systemType;
        Fleet.Info fleet;
        uint256 investment;
        uint256 tokenId;
        uint32 yield;
        bool hasFleet;
    }

    function randomSystemType() internal returns (SystemType systemType) {
        uint32 roll = uint32(Random.randrange(1, 10000)); // roll out of 10000

        if (roll < 50) {
            systemType = SystemType.Empty;
        } else if (roll > 51 && roll <= 300) {
            systemType = SystemType.LowYieldSystem;
        } else if (roll > 300 && roll <= 600) {
            systemType = SystemType.MediumYieldSystem;
        } else if (roll > 600 && roll <= 900) {
            systemType = SystemType.HighYieldSystem;
        } else if (roll > 900 && roll <= 999) {
            systemType = SystemType.HighYieldSystem;
        } else if (roll == 10000) {
            systemType = SystemType.AncientShipWreck;
        }
    }

    function randomYield(SystemType systemType) internal returns (uint32 rand) {
        if (systemType == SystemType.LowYieldSystem) {
            rand = uint32(Random.randrange(LOW_YIELD_LOW, LOW_YIELD_HIGH));
        } else if (systemType == SystemType.MediumYieldSystem) {
            rand = uint32(
                Random.randrange(MEDIUM_YIELD_LOW, MEDIUM_YIELD_HIGH)
            );
        } else if (systemType == SystemType.LowYieldSystem) {
            rand = uint32(Random.randrange(HIGH_YIELD_LOW, HIGH_YIELD_HIGH));
        } else if (systemType == SystemType.LowYieldSystem) {
            rand = uint32(
                Random.randrange(INSANE_YIELD_LOW, INSANE_YIELD_HIGH)
            );
        }
    }
}
