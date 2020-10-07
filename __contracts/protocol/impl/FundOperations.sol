// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Events} from '../lib/Events.sol';
import {Storage} from '../lib/Storage.sol';
import {ISolar} from '../interfaces/ISolar.sol';
import {Rewards} from '../lib/Rewards.sol';

/**
 * @title Operation
 * @author Big Beluga
 *
 * Primary public function for entering into the protocol
 */
library FundOperations {
    using SafeMath for uint256;
    using Storage for Storage.State;

    // ============ Constants ============

    bytes32 constant FILE = 'Operation';

    function deposit(
        Storage.State storage state,
        uint256 amount,
        uint256 length
    ) public {
        require(
            amount > 0,
            'FundOperations#Deposit: Amount must be greater than 0'
        );

        require(
            length > 0,
            'FundOperations#Deposit: Time must be greater than 0'
        );

        uint256 reward = Rewards.calculateReward(amount, length);

        address solar = Storage.getSolarAddress(state);
        ISolar(solar).transferFrom(msg.sender, address(this), amount);

        Storage.lockinSolar(state, msg.sender, amount, length, reward);

        Events.logDeposit(state, solar, amount, reward);
    }

    function withdraw(Storage.State storage state) public {
        require(
            Storage.isWithdrawable(state, msg.sender),
            'FundOperations#Withdraw: Stake period is not complete'
        );

        uint256 reward = Storage.getReward(state, msg.sender);
        uint256 balance = Storage.getBalance(state, msg.sender);
        address solar = Storage.getSolarAddress(state);

        ISolar(solar).mint(address(this), reward);
        ISolar(solar).transfer(msg.sender, balance + reward);

        Storage.unlockSolar(state, msg.sender);
        Events.logWithdraw(state, msg.sender, reward);
    }

    function emergencyWithdraw(Storage.State storage state) public {
        uint256 reward = Storage.getReward(state, msg.sender);
        uint256 dateUnlocked = Storage.getDateUnlocked(state, msg.sender);

        uint256 emergancyPercent = ((dateUnlocked / now) * 100) / 50;
        uint256 actualReward = (reward / 100) * emergancyPercent;
        uint256 balance = Storage.getBalance(state, msg.sender);
        address solar = Storage.getSolarAddress(state);

        ISolar(solar).mint(address(this), actualReward);
        ISolar(solar).transfer(msg.sender, balance + actualReward);

        Storage.unlockSolar(state, msg.sender);
        Events.logWithdraw(state, msg.sender, actualReward);
    }
}
