// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Events} from '../lib/Events.sol';
import {Storage} from '../lib/Storage.sol';
import {ITsuno} from '../interfaces/ITsuno.sol';
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

        address tsuno = Storage.getTsuno(state);
        ITsuno(tsuno).transferFrom(msg.sender, address(this), amount);

        Storage.lockinTsuno(state, msg.sender, amount, length, reward);

        Events.logDeposit(state, tsuno, amount, reward);
    }

    function withdraw(Storage.State storage state) public {
        require(
            Storage.isWithdrawable(state, msg.sender),
            'FundOperations#Withdraw: Stake period is not complete'
        );

        uint256 reward = Storage.getReward(state, msg.sender);
        uint256 balance = Storage.getBalance(state, msg.sender);
        address tsuno = Storage.getTsuno(state);

        ITsuno(tsuno).mint(address(this), reward);
        ITsuno(tsuno).transfer(msg.sender, balance + reward);

        Storage.unlockTsuno(state, msg.sender);
        Events.logWithdraw(state, msg.sender, reward);
    }

    function emergencyWithdraw(Storage.State storage state) public {
        uint256 reward = Storage.getReward(state, msg.sender);
        uint256 dateUnlocked = Storage.getDateUnlocked(state, msg.sender);

        uint256 emergancyPercent = ((dateUnlocked / now) * 100) / 50;
        uint256 actualReward = (reward / 100) * emergancyPercent;
        uint256 balance = Storage.getBalance(state, msg.sender);
        address tsuno = Storage.getTsuno(state);

        ITsuno(tsuno).mint(address(this), actualReward);
        ITsuno(tsuno).transfer(msg.sender, balance + actualReward);

        Storage.unlockTsuno(state, msg.sender);
        Events.logWithdraw(state, msg.sender, actualReward);
    }
}
