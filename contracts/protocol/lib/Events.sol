// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Storage} from './Storage.sol';

/**
 * @title Events
 * @author Big Beluga
 *
 * Library to parse and emit logs from which the state of all accounts and indexes can be followed
 */
library Events {
    using Storage for Storage.State;

    // ============ Events ============

    event LogDeposit(
        address indexed user,
        uint256 amount,
        uint256 balance,
        uint256 reward
    );
    event LogWithdraw(address indexed user, uint256 amount, uint256 balance);
    event LogBattle(
        address indexed attacker,
        address indexed defender,
        bool winner,
        string battleLog
    );

    // ============ Internal Functions ============
    function logBattle(
        address attacker,
        address defender,
        bool winner,
        string memory battleLog
    ) internal {
        emit LogBattle(attacker, defender, winner, battleLog);
    }

    function logDeposit(
        Storage.State storage state,
        address user,
        uint256 amount,
        uint256 reward
    ) internal {
        emit LogDeposit(user, amount, state.getBalance(user), reward);
    }

    function logWithdraw(
        Storage.State storage state,
        address user,
        uint256 amount
    ) internal {
        emit LogWithdraw(user, amount, state.getBalance(user));
    }
}
