// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Random} from './Random.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Fleet} from './Fleet.sol';
import {Events} from './Events.sol';
import {Constants} from './Constants.sol';

/**
 * @title Star System
 * @author Jim Dawson
 *
 * Library for transferring tokens and interacting with ExchangeWrappers by using the Wei struct
 */
library StarSystem {
    using SafeMath for uint256;

    enum SystemType {
        Undiscovered,
        AncientFleetAggressive,
        SuperComputerEvent,
        AdvancedAlienFleetAggressive,
        AiFleetAggressive,
        AlienFleetAggressive,
        PiratesEvent,
        SolarWinds,
        Asteroids,
        Empty,
        GovermentOwned,
        LowYieldSystem,
        RandomEvent,
        MediumYieldSystem,
        ShipWreck,
        HighYieldSystem,
        AncientMiningSystem,
        AncientWeaponSystem,
        AncientShipWreck,
        InsaneYieldSystem,
        AncientRacePassive
    }
    struct Info {
        SystemType systemType;
        Fleet.Info fleet;
        uint256 investment;
        uint256 tokenId;
        uint16 yield;
        bool hasFleet;
    }

    function randomSystemType()
        internal
        returns (SystemType systemType, uint256 rand)
    {
        rand = Random.randrange(1, Constants.MAX_ROLL);
        uint16 roll = uint16(rand); // roll out of 10000
        // TODO: replace hard coded numbers with constants once we are happy with
        // the number of SystemTypes that we want tot have in play

        Events.logRandom(rand);
        Events.logRandom(roll);
        if (roll == 1) {
            systemType = SystemType.AncientFleetAggressive;
        } else if (roll == 42) {
            systemType = SystemType.SuperComputerEvent;
        } else if (roll <= Constants.ONE_PERCENT_MAX_ROLL * 5) {
            systemType = SystemType.AdvancedAlienFleetAggressive;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 5 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL * 10
        ) {
            systemType = SystemType.AiFleetAggressive;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 10 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL * 20
        ) {
            systemType = SystemType.AlienFleetAggressive;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 20 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL * 30
        ) {
            systemType = SystemType.PiratesEvent;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 30 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL * 35
        ) {
            systemType = SystemType.SolarWinds;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 35 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL * 40
        ) {
            systemType = SystemType.Asteroids;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 40 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL * 47
        ) {
            systemType = SystemType.Empty;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 47 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL * 60
        ) {
            systemType = SystemType.GovermentOwned;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 60 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL * 65
        ) {
            systemType = SystemType.LowYieldSystem;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 65 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL * 70
        ) {
            systemType = SystemType.RandomEvent;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 70 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL & 75
        ) {
            systemType = SystemType.MediumYieldSystem;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 70 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL & 80
        ) {
            systemType = SystemType.ShipWreck;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 80 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL & 85
        ) {
            systemType = SystemType.HighYieldSystem;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 85 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL & 90
        ) {
            systemType = SystemType.AncientMiningSystem;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 90 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL & 95
        ) {
            systemType = SystemType.AncientWeaponSystem;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 95 &&
            roll <= Constants.ONE_PERCENT_MAX_ROLL & 99
        ) {
            systemType = SystemType.AncientShipWreck;
        } else if (
            roll > Constants.ONE_PERCENT_MAX_ROLL * 99 &&
            roll <= Constants.MAX_ROLL - 1
        ) {
            systemType = SystemType.InsaneYieldSystem;
        } else if (roll == Constants.MAX_ROLL) {
            systemType = SystemType.AncientRacePassive;
        } else {
            systemType = SystemType.Empty;
        }
    }

    function randomYield(SystemType systemType) internal returns (uint16 rand) {
        if (systemType == SystemType.LowYieldSystem) {
            rand = uint16(
                Random.randrange(
                    Constants.LOW_YIELD_LOW,
                    Constants.LOW_YIELD_HIGH
                )
            );
        } else if (systemType == SystemType.MediumYieldSystem) {
            rand = uint16(
                Random.randrange(
                    Constants.MEDIUM_YIELD_LOW,
                    Constants.MEDIUM_YIELD_HIGH
                )
            );
        } else if (systemType == SystemType.LowYieldSystem) {
            rand = uint16(
                Random.randrange(
                    Constants.HIGH_YIELD_LOW,
                    Constants.HIGH_YIELD_HIGH
                )
            );
        } else if (systemType == SystemType.LowYieldSystem) {
            rand = uint16(
                Random.randrange(
                    Constants.INSANE_YIELD_LOW,
                    Constants.INSANE_YIELD_HIGH
                )
            );
        }
    }
}
