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
library SATs {
    using SafeMath for uint256;

    enum ShipAndTechList {
        FEDERATION_CRUISER,
        FEDERATION_DESTROYER,
        FEDERATION_MASTER_VESSEL,
        FEDERATION_FIGHTER_PLANE,
        FEDERATION_MARKET_SHIP,
        FEDERATION_MINING_SHIP_SMALL,
        FEDERATION_MINING_SHIP_MEDIUM,
        FEDERATION_MINING_SHIP_LARGE,
        FEDERATION_WEAPON_SYSTEM_SMALL,
        FEDERATION_WEAPON_SYSTEM_MEDIUM,
        FEDERATION_WEAPON_SYSTEM_LARGE,
        ALIEN_MASTER_VESSEL,
        ALIEN_CRUISER,
        ALIEN_DESTROYER,
        ALIEN_FIGHTER_PLANE,
        ALIEN_MARKET_SHIP,
        ALIEN_MINING_SHIP_SMALL,
        ALIEN_MINING_SHIP_MEDIUM,
        ALIEN_MINING_SHIP_LARGE,
        ALIEN_WEAPON_SYSTEM_SMALL,
        ALIEN_WEAPON_SYSTEM_MEDIUM,
        ALIEN_WEAPON_SYSTEM_LARGE,
        ADVANCED_RACE_MASTER_VESSEL,
        ADVANCED_RACE_CRUISER,
        ADVANCED_RACE_DESTROYER,
        ADVANCED_RACE_FIGHTER_PLANE,
        ADVANCED_RACE_MARKET_SHIP,
        ADVANCED_RACE_MINING_SHIP_SMALL,
        ADVANCED_RACE_MINING_SHIP_MEDIUM,
        ADVANCED_RACE_MINING_SHIP_LARGE,
        ADVANCED_RACE_WEAPON_SYSTEM_SMALL,
        ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM,
        ADVANCED_RACE_WEAPON_SYSTEM_LARGE,
        ANCIENT_MASTER_VESSEL,
        ANCIENT_CRUISER,
        ANCIENT_DESTROYER,
        ANCIENT_FIGHTER_PLANE,
        ANCIENT_MARKET_SHIP,
        ANCIENT_MINING_SHIP_SMALL,
        ANCIENT_MINING_SHIP_MEDIUM,
        ANCIENT_MINING_SHIP_LARGE,
        ANCIENT_WEAPON_SYSTEM_SMALL,
        ANCIENT_WEAPON_SYSTEM_MEDIUM,
        ANCIENT_WEAPON_SYSTEM_LARGE,
        PIRATE_SHIP,
        PIRATE_WEAPON
    }

    struct Info {
        uint256 amount;
        uint256 id;
    }

    function getFederationShips() internal pure returns (uint256[8] memory) {
        return [
            uint256(ShipAndTechList.FEDERATION_CRUISER),
            uint256(ShipAndTechList.FEDERATION_DESTROYER),
            uint256(ShipAndTechList.FEDERATION_MASTER_VESSEL),
            uint256(ShipAndTechList.FEDERATION_FIGHTER_PLANE),
            uint256(ShipAndTechList.FEDERATION_MARKET_SHIP),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_LARGE)
        ];
    }

    function getFederationWeapons() internal pure returns (uint256[3] memory) {
        return [
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_LARGE)
        ];
    }

    function getAlienShips() internal pure returns (uint256[8] memory) {
        return [
            uint256(ShipAndTechList.ALIEN_CRUISER),
            uint256(ShipAndTechList.ALIEN_DESTROYER),
            uint256(ShipAndTechList.ALIEN_MASTER_VESSEL),
            uint256(ShipAndTechList.ALIEN_FIGHTER_PLANE),
            uint256(ShipAndTechList.ALIEN_MARKET_SHIP),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_LARGE)
        ];
    }

    function getAlienWeapons() internal pure returns (uint256[3] memory) {
        return [
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_LARGE)
        ];
    }

    function getAdvancedRaceShips() internal pure returns (uint256[8] memory) {
        return [
            uint256(ShipAndTechList.ADVANCED_RACE_CRUISER),
            uint256(ShipAndTechList.ADVANCED_RACE_DESTROYER),
            uint256(ShipAndTechList.ADVANCED_RACE_MASTER_VESSEL),
            uint256(ShipAndTechList.ADVANCED_RACE_FIGHTER_PLANE),
            uint256(ShipAndTechList.ADVANCED_RACE_MARKET_SHIP),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_LARGE)
        ];
    }

    function getAdvancedRaceWeapons()
        internal
        pure
        returns (uint256[3] memory)
    {
        return [
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_LARGE)
        ];
    }

    function getAnecienteShips() internal pure returns (uint256[8] memory) {
        return [
            uint256(ShipAndTechList.ANCIENT_CRUISER),
            uint256(ShipAndTechList.ANCIENT_DESTROYER),
            uint256(ShipAndTechList.ANCIENT_MASTER_VESSEL),
            uint256(ShipAndTechList.ANCIENT_FIGHTER_PLANE),
            uint256(ShipAndTechList.ANCIENT_MARKET_SHIP),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_LARGE)
        ];
    }

    function getAncientMiningShip() internal pure returns (uint256[3] memory) {
        return [
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_LARGE)
        ];
    }

    function getAncientWeapons() internal pure returns (uint256[3] memory) {
        return [
            uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_LARGE)
        ];
    }

    function getPirateShips() internal pure returns (uint256[1] memory) {
        return [uint256(ShipAndTechList.PIRATE_SHIP)];
    }

    function getAllNonAncientShips()
        internal
        pure
        returns (uint256[24] memory)
    {
        return [
            uint256(ShipAndTechList.FEDERATION_CRUISER),
            uint256(ShipAndTechList.FEDERATION_DESTROYER),
            uint256(ShipAndTechList.FEDERATION_MASTER_VESSEL),
            uint256(ShipAndTechList.FEDERATION_FIGHTER_PLANE),
            uint256(ShipAndTechList.FEDERATION_MARKET_SHIP),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_LARGE),
            uint256(ShipAndTechList.ALIEN_CRUISER),
            uint256(ShipAndTechList.ALIEN_DESTROYER),
            uint256(ShipAndTechList.ALIEN_MASTER_VESSEL),
            uint256(ShipAndTechList.ALIEN_FIGHTER_PLANE),
            uint256(ShipAndTechList.ALIEN_MARKET_SHIP),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_LARGE),
            uint256(ShipAndTechList.ADVANCED_RACE_CRUISER),
            uint256(ShipAndTechList.ADVANCED_RACE_DESTROYER),
            uint256(ShipAndTechList.ADVANCED_RACE_MASTER_VESSEL),
            uint256(ShipAndTechList.ADVANCED_RACE_FIGHTER_PLANE),
            uint256(ShipAndTechList.ADVANCED_RACE_MARKET_SHIP),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_LARGE)
        ];
    }

    function getAllShips() internal pure returns (uint256[33] memory) {
        return [
            uint256(ShipAndTechList.FEDERATION_CRUISER),
            uint256(ShipAndTechList.FEDERATION_DESTROYER),
            uint256(ShipAndTechList.FEDERATION_MASTER_VESSEL),
            uint256(ShipAndTechList.FEDERATION_FIGHTER_PLANE),
            uint256(ShipAndTechList.FEDERATION_MARKET_SHIP),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.FEDERATION_MINING_SHIP_LARGE),
            uint256(ShipAndTechList.ALIEN_CRUISER),
            uint256(ShipAndTechList.ALIEN_DESTROYER),
            uint256(ShipAndTechList.ALIEN_MASTER_VESSEL),
            uint256(ShipAndTechList.ALIEN_FIGHTER_PLANE),
            uint256(ShipAndTechList.ALIEN_MARKET_SHIP),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ALIEN_MINING_SHIP_LARGE),
            uint256(ShipAndTechList.ADVANCED_RACE_CRUISER),
            uint256(ShipAndTechList.ADVANCED_RACE_DESTROYER),
            uint256(ShipAndTechList.ADVANCED_RACE_MASTER_VESSEL),
            uint256(ShipAndTechList.ADVANCED_RACE_FIGHTER_PLANE),
            uint256(ShipAndTechList.ADVANCED_RACE_MARKET_SHIP),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ADVANCED_RACE_MINING_SHIP_LARGE),
            uint256(ShipAndTechList.ANCIENT_CRUISER),
            uint256(ShipAndTechList.ANCIENT_DESTROYER),
            uint256(ShipAndTechList.ANCIENT_MASTER_VESSEL),
            uint256(ShipAndTechList.ANCIENT_FIGHTER_PLANE),
            uint256(ShipAndTechList.ANCIENT_MARKET_SHIP),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_SMALL),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_MEDIUM),
            uint256(ShipAndTechList.ANCIENT_MINING_SHIP_LARGE),
            uint256(ShipAndTechList.PIRATE_SHIP)
        ];
    }

    function getAllNonAncientWeapons()
        internal
        pure
        returns (uint256[9] memory)
    {
        return [
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_LARGE),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_LARGE),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_LARGE)
        ];
    }

    function getAllWeapons() internal pure returns (uint256[12] memory) {
        return [
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.FEDERATION_WEAPON_SYSTEM_LARGE),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ALIEN_WEAPON_SYSTEM_LARGE),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ADVANCED_RACE_WEAPON_SYSTEM_LARGE),
            uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_SMALL),
            uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_MEDIUM),
            uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_LARGE)
        ];
    }
}
