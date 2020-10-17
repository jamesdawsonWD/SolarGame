// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Random} from './Random.sol';
import {Types} from './lib/Types.sol';

contract Discovery is Random {
    enum DiscoveryLevels {
        OnlyFederation,
        OnlyAlien,
        AlienAndFederation,
        OnlyAncient,
        OnlyAi,
        AllButAncient,
        All
    }

    function federationShips(uint256 amount) internal returns (Types.SatInfo memory) {
        uint256[8] memory _ids = Types.getFederationShips();

        uint256 pos = randomrange(0, _ids.length);
        uint256 _id = _ids[pos];

        return Types.SatInfo({id: _id, amount: amount});
    }

    function singleFederationShip(uint256 amount) internal returns (Types.SatInfo memory) {
        uint256[8] memory _ids = Types.getFederationShips();

        uint256 pos = randomrange(0, _ids.length);
        uint256 _id = _ids[pos];

        return Types.SatInfo({id: _id, amount: 1});
    }

    function singleAncientMiningShip() internal returns (Types.SatInfo memory) {
        uint256[3] memory _ids = Types.getAncientMiningShip();

        uint256 pos = randomrange(0, _ids.length);
        uint256 _id = _ids[pos];

        return Types.SatInfo({id: _id, amount: 1});
    }

    function singleAllNonAncientShips() internal returns (Types.SatInfo memory) {
        uint256[24] memory _ids = Types.getAllNonAncientShips();

        uint256 pos = randomrange(0, _ids.length);
        uint256 _id = _ids[pos];

        return Types.SatInfo({id: _id, amount: 1});
    }

    function randomSystemType() internal returns (Types.SystemType systemType, uint256 rand) {
        uint256 MAX_ROLL = 10000;
        uint256 ONE_PERCENT = MAX_ROLL / 100;
        rand = randomrange(1, MAX_ROLL);
        uint16 roll = uint16(rand);
        if (roll == 1) {
            systemType = Types.SystemType.AncientFleetAggressive;
        } else if (roll == 42) {
            systemType = Types.SystemType.SuperComputerEvent;
        } else if (roll <= ONE_PERCENT * 5) {
            systemType = Types.SystemType.AdvancedAlienFleetAggressive;
        } else if (roll > ONE_PERCENT * 5 && roll <= ONE_PERCENT * 10) {
            systemType = Types.SystemType.AiFleetAggressive;
        } else if (roll > ONE_PERCENT * 10 && roll <= ONE_PERCENT * 20) {
            systemType = Types.SystemType.AlienFleetAggressive;
        } else if (roll > ONE_PERCENT * 20 && roll <= ONE_PERCENT * 30) {
            systemType = Types.SystemType.PiratesEvent;
        } else if (roll > ONE_PERCENT * 30 && roll <= ONE_PERCENT * 35) {
            systemType = Types.SystemType.SolarWinds;
        } else if (roll > ONE_PERCENT * 35 && roll <= ONE_PERCENT * 40) {
            systemType = Types.SystemType.Asteroids;
        } else if (roll > ONE_PERCENT * 40 && roll <= ONE_PERCENT * 47) {
            systemType = Types.SystemType.Empty;
        } else if (roll > ONE_PERCENT * 47 && roll <= ONE_PERCENT * 60) {
            systemType = Types.SystemType.GovermentOwned;
        } else if (roll > ONE_PERCENT * 60 && roll <= ONE_PERCENT * 65) {
            systemType = Types.SystemType.LowYieldSystem;
        } else if (roll > ONE_PERCENT * 65 && roll <= ONE_PERCENT * 70) {
            systemType = Types.SystemType.RandomEvent;
        } else if (roll > ONE_PERCENT * 70 && roll <= ONE_PERCENT & 75) {
            systemType = Types.SystemType.MediumYieldSystem;
        } else if (roll > ONE_PERCENT * 70 && roll <= ONE_PERCENT & 80) {
            systemType = Types.SystemType.ShipWreck;
        } else if (roll > ONE_PERCENT * 80 && roll <= ONE_PERCENT & 85) {
            systemType = Types.SystemType.HighYieldSystem;
        } else if (roll > ONE_PERCENT * 85 && roll <= ONE_PERCENT & 90) {
            systemType = Types.SystemType.AncientMiningSystem;
        } else if (roll > ONE_PERCENT * 90 && roll <= ONE_PERCENT & 95) {
            systemType = Types.SystemType.AncientWeaponSystem;
        } else if (roll > ONE_PERCENT * 95 && roll <= ONE_PERCENT & 99) {
            systemType = Types.SystemType.AncientShipWreck;
        } else if (roll > ONE_PERCENT * 99 && roll <= MAX_ROLL - 1) {
            systemType = Types.SystemType.InsaneYieldSystem;
        } else if (roll == MAX_ROLL) {
            systemType = Types.SystemType.AncientRacePassive;
        } else {
            systemType = Types.SystemType.Empty;
        }
    }

    function getRandomYield(Types.SystemType systemType) public view returns (uint16 rand) {}
}
