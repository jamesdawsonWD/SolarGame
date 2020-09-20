// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Master} from '../protocol/master.sol';

contract TestMaster is Master {
    constructor(address tsuno) public Master(tsuno) {}

    function giveArmyA() public {
        g_state.masters[msg.sender].army.soldiers = 1000;
        g_state.masters[msg.sender].army.cavalry = 1000;
        g_state.masters[msg.sender].army.archers = 1000;
        g_state.masters[msg.sender].army.siegeWeapons = 0;
        g_state.masters[msg.sender].army.defenceStructures = 1000;
    }

    function get1() public pure returns (uint256) {
        return 1;
    }

    function giveArmyB() public {
        g_state.masters[msg.sender].army.soldiers = 1000;
        g_state.masters[msg.sender].army.cavalry = 1000;
        g_state.masters[msg.sender].army.archers = 1000;
        g_state.masters[msg.sender].army.siegeWeapons = 500;
        g_state.masters[msg.sender].army.defenceStructures = 750;
    }
}
