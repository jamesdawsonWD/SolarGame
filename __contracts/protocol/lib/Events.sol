// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Storage} from './Storage.sol';
import {StarSystem} from './StarSystem.sol';

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
    event LogMove(uint8 quadrant, uint8 distract, uint8 sector, uint32 star);
    event LogStarSystemDiscovery(address indexed to, uint8 systemType);
    event Random(uint256 random);

    // Goverance
    event ProposalCreated(
        uint256 id,
        address proposer,
        address[] targets,
        uint256[] values,
        string[] signatures,
        bytes[] calldatas,
        uint256 startBlock,
        uint256 endBlock,
        string description
    );

    /// @notice An event emitted when a vote has been cast on a proposal
    event VoteCast(
        address voter,
        uint256 proposalId,
        bool support,
        uint256 votes
    );

    /// @notice An event emitted when a proposal has been canceled
    event ProposalCanceled(uint256 id);

    /// @notice An event emitted when a proposal has been queued in the Timelock
    event ProposalQueued(uint256 id, uint256 eta);

    /// @notice An event emitted when a proposal has been executed in the Timelock
    event ProposalExecuted(uint256 id);

    function logProposalCreated(
        uint256 id,
        address proposer,
        address[] memory targets,
        uint256[] memory values,
        string[] memory signatures,
        bytes[] memory calldatas,
        uint256 startBlock,
        uint256 endBlock,
        string memory description
    ) internal {
        emit ProposalCreated(
            id,
            proposer,
            targets,
            values,
            signatures,
            calldatas,
            startBlock,
            endBlock,
            description
        );
    }

    function logVoteCast(
        address voter,
        uint256 proposalId,
        bool support,
        uint256 votes
    ) internal {
        emit VoteCast(voter, proposalId, support, votes);
    }

    function logProposalCancled(uint256 id) internal {
        emit ProposalCanceled(id);
    }

    function logProposalQueued(uint256 id, uint256 eta) internal {
        emit ProposalQueued(id, eta);
    }

    function logProposalExecuted(uint256 id) internal {
        emit ProposalExecuted(id);
    }

    function logRandom(uint256 random) internal {
        emit Random(random);
    }

    function logMove(
        uint8 quadrant,
        uint8 distract,
        uint8 sector,
        uint32 star
    ) internal {
        emit LogMove(quadrant, distract, sector, star);
    }

    function logStarSystemDiscovery(
        address to,
        StarSystem.SystemType systemType
    ) internal {
        emit LogStarSystemDiscovery(to, uint8(systemType));
    }

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
