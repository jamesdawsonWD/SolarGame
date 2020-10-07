// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
import {ERC1155} from '@openzeppelin/contracts/token/ERC1155/ERC1155.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {EternalStorage} from './EternalStorage.sol';

contract ShipsAndTechnology is Ownable, ERC1155 {
    EternalStorage es;
    uint16 constant TOTAL_STARTING_ITEMS = 46;

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

    constructor(address _es, address _holder)
        public
        ERC1155('https://game.example/api/item/{1}.json')
    {
        es = EternalStorage(_es);
        for (uint256 i = 0; i < TOTAL_STARTING_ITEMS; i++) {
            _mint(_holder, i, getAmount(i), '');
        }
    }

    modifier onlyOperator() {
        // Make sure the access is permitted to only contracts in our Dapp
        require(
            es.getAddress(keccak256(abi.encodePacked('sats.access', msg.sender))) != address(0x0)
        );
        _;
    }

    function getAmount(uint256 i) private returns (uint256 amount) {
        if (
            i == uint256(ShipAndTechList.ANCIENT_MINING_SHIP_SMALL) ||
            i == uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_SMALL) ||
            i == uint256(ShipAndTechList.ANCIENT_CRUISER)
        ) {
            amount = 1000;
        } else if (
            i == uint256(ShipAndTechList.ANCIENT_MINING_SHIP_MEDIUM) ||
            i == uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_SMALL) ||
            i == uint256(ShipAndTechList.ANCIENT_DESTROYER)
        ) {
            amount = 400;
        } else if (
            i == uint256(ShipAndTechList.ANCIENT_WEAPON_SYSTEM_LARGE) ||
            i == uint256(ShipAndTechList.ANCIENT_MINING_SHIP_LARGE)
        ) {
            amount = 100;
        } else if (i == uint256(ShipAndTechList.ANCIENT_MASTER_VESSEL)) {
            amount = 10;
        } else if (i == uint256(ShipAndTechList.ANCIENT_FIGHTER_PLANE)) {
            amount = 10000;
        } else {
            amount = 10**9;
        }
    }
}
