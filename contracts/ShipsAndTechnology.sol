// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
import {ERC1155} from '@openzeppelin/contracts/token/ERC1155/ERC1155.sol';
import {Ownable} from '@openzeppelin/contracts/access/Ownable.sol';
import {EternalStorage} from './EternalStorage.sol';

contract ShipsAndTechnology is Ownable, ERC1155 {
    EternalStorage es;
    uint16 constant TOTAL_STARTING_ITEMS = 46;
    mapping(address => bool) operators;

    enum ShipAndTechList {
        FEDERATION_CRUISER,
        FEDERATION_DESTROYER,
        FEDERATION_MASTER_VESSEL,
        FEDERATION_FIGHTER_PLANE,
        ALIEN_MASTER_VESSEL,
        ALIEN_CRUISER,
        ALIEN_DESTROYER,
        ALIEN_FIGHTER_PLANE,
        ADVANCED_RACE_MASTER_VESSEL,
        ADVANCED_RACE_CRUISER,
        ADVANCED_RACE_DESTROYER,
        ADVANCED_RACE_FIGHTER_PLANE,
        ANCIENT_MASTER_VESSEL,
        ANCIENT_CRUISER,
        ANCIENT_DESTROYER,
        ANCIENT_FIGHTER_PLANE,
        PIRATE_SHIP,
        PIRATE_WEAPON
    }

    constructor(address _holder) public ERC1155('https://game.example/api/item/{1}.json') {
        for (uint256 i = 0; i < TOTAL_STARTING_ITEMS; i++) {
            _mint(_holder, i, getAmount(i), '');
        }
        addOperator(_holder);
    }

    function addOperator(address _operator) public onlyOwner {
        operators[_operator] = true;
    }

    modifier onlyOperator() {
        // Make sure the access is permitted to only contracts in our Dapp
        require(operators[msg.sender], 'Only Operator');
        _;
    }

    function getAmount(uint256 i) private returns (uint256 amount) {
        if (i == uint256(ShipAndTechList.ANCIENT_CRUISER)) {
            amount = 1000;
        } else if (i == uint256(ShipAndTechList.ANCIENT_DESTROYER)) {
            amount = 400;
        } else if (i == uint256(ShipAndTechList.ANCIENT_MASTER_VESSEL)) {
            amount = 10;
        } else if (i == uint256(ShipAndTechList.ANCIENT_FIGHTER_PLANE)) {
            amount = 10000;
        } else {
            amount = 10**9;
        }
    }
}
