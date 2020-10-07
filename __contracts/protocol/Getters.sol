// SPDX-License-Identifier: MIT

// code to deploy DyDx solo protocol locally
pragma solidity 0.6.12;
import {State} from './State.sol';
import {Storage} from './lib/Storage.sol';
import {Rewards} from './lib/Rewards.sol';

contract Getters is State {
    function getBalance() public view returns (uint256) {
        return Storage.getBalance(g_state, msg.sender);
    }

    function getReward() public view returns (uint256) {
        return Storage.getReward(g_state, msg.sender);
    }

    function getPotentialReward(uint256 stakeTsuno, uint256 stakedDays)
        public
        returns (uint256)
    {
        return Rewards.calculateReward(stakeTsuno, stakedDays);
    }

    function getDateUnlocked() public view returns (uint256) {
        return Storage.getDateUnlocked(g_state, msg.sender);
    }
}
