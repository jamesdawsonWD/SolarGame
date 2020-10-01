// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Master} from '../protocol/master.sol';
import {
    ERC1155Holder
} from '@openzeppelin/contracts/token/ERC1155/ERC1155Holder.sol';

contract TestMaster is Master, ERC1155Holder {
    constructor() public Master() {}

    // function giveArmyA() public {
    //     g_state.masters[msg.sender].army.soldiers = 1000;
    //     g_state.masters[msg.sender].army.cavalry = 1000;
    //     g_state.masters[msg.sender].army.archers = 1000;
    //     g_state.masters[msg.sender].army.siegeWeapons = 0;
    //     g_state.masters[msg.sender].army.defenceStructures = 1000;
    // }

    // function giveArmyB() public {
    //     g_state.masters[msg.sender].army.soldiers = 1000;
    //     g_state.masters[msg.sender].army.cavalry = 1000;
    //     g_state.masters[msg.sender].army.archers = 1000;
    //     g_state.masters[msg.sender].army.siegeWeapons = 500;
    //     g_state.masters[msg.sender].army.defenceStructures = 750;
    // }
}
