// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Events} from '../lib/Events.sol';
import {Storage} from '../lib/Storage.sol';
import {ISolar} from '../interfaces/ISolar.sol';
import {Rewards} from '../lib/Rewards.sol';
import {Types} from '../lib/Types.sol';
import {Constants} from '../lib/Constants.sol';
import {ITimeLock} from '../interfaces/ITimeLock.sol';
import {Governance} from '../lib/Governance.sol';

/**
 * @title Governance Operations
 * @author James Dawson
 *
 * Primary public functions for changing the state of the games constant variables.
 * Can only be triggered by a Governance vote.
 */
library GovernanceOperations {
    using SafeMath for uint256;
    using Storage for Storage.State;

    bytes32 constant FILE = 'Operation';

    /// @notice The name of this contract
    // XXX: string public constant name = "Compound Governor Alpha";
    // string public constant name = 'Sushi Governor Alpha';

    /// @notice The number of votes required in order for a voter to become a proposer
    // function proposalThreshold() public pure returns (uint) { return 100000e18; } // 100,000 = 1% of Comp
    // function proposalThreshold(Storage.State storage state)
    //     public
    //     view
    //     returns (uint256)
    // {
    //     return ISolar(state.getSolarAddress()).totalSupply() / 100;
    // } // 1% of Supply

    /// @notice The maximum number of actions that can be included in a proposal
    // function proposalMaxOperations() public pure returns (uint256) {
    //     return 10;
    // } // 10 actions

    // /// @notice The delay before voting on a proposal may take place, once proposed
    // function votingDelay() public pure returns (uint256) {
    //     return 1;
    // } // 1 block

    // /// @notice The duration of voting on a proposal, in blocks
    // function votingPeriod() public pure returns (uint256) {
    //     return 17280;
    // } // ~3 days in blocks (assuming 15s blocks)

    /// @notice The address of the Compound Protocol Timelock
    // TimelockInterface public timelock;

    /// @notice The address of the Compound governance token
    // XXX: CompInterface public comp;
    // SushiToken public sushi;

    /// @notice The address of the Governor Guardian
    // address public guardian;

    /// @notice The total number of proposals
    // uint256 public proposalCount;

    // struct Proposal {
    //     /// @notice Unique id for looking up a proposal
    //     uint256 id;
    //     /// @notice Creator of the proposal
    //     address proposer;
    //     /// @notice The timestamp that the proposal will be available for execution, set once the vote succeeds
    //     uint256 eta;
    //     /// @notice the ordered list of target addresses for calls to be made
    //     address[] targets;
    //     /// @notice The ordered list of values (i.e. msg.value) to be passed to the calls to be made
    //     uint256[] values;
    //     /// @notice The ordered list of function signatures to be called
    //     string[] signatures;
    //     /// @notice The ordered list of calldata to be passed to each call
    //     bytes[] calldatas;
    //     /// @notice The block at which voting begins: holders must delegate their votes prior to this block
    //     uint256 startBlock;
    //     /// @notice The block at which voting ends: votes must be cast prior to this block
    //     uint256 endBlock;
    //     /// @notice Current number of votes in favor of this proposal
    //     uint256 forVotes;
    //     /// @notice Current number of votes in opposition to this proposal
    //     uint256 againstVotes;
    //     /// @notice Flag marking whether the proposal has been canceled
    //     bool canceled;
    //     /// @notice Flag marking whether the proposal has been executed
    //     bool executed;
    //     /// @notice Receipts of ballots for the entire set of voters
    //     mapping(address => Receipt) receipts;
    // }

    // /// @notice Ballot receipt record for a voter
    // struct Receipt {
    //     /// @notice Whether or not a vote has been cast
    //     bool hasVoted;
    //     /// @notice Whether or not the voter supports the proposal
    //     bool support;
    //     /// @notice The number of votes the voter had, which were cast
    //     uint256 votes;
    // }

    /// @notice Possible states that a proposal may be in
    // enum ProposalState {
    //     Pending,
    //     Active,
    //     Canceled,
    //     Defeated,
    //     Succeeded,
    //     Queued,
    //     Expired,
    //     Executed
    // }

    /// @notice The official record of all proposals ever proposed
    // mapping(uint256 => Proposal) public proposals;

    /// @notice The latest proposal for each proposer
    // mapping(address => uint256) public latestProposalIds;

    /// @notice The EIP-712 typehash for the contract's domain
    // bytes32 public constant DOMAIN_TYPEHASH = keccak256(
    //     'EIP712Domain(string name,uint256 chainId,address verifyingContract)'
    // );

    // /// @notice The EIP-712 typehash for the ballot struct used by the contract
    // bytes32 public constant BALLOT_TYPEHASH = keccak256(
    //     'Ballot(uint256 proposalId,bool support)'
    // );

    /// @notice An event emitted when a new proposal is created
    // event ProposalCreated(
    //     uint256 id,
    //     address proposer,
    //     address[] targets,
    //     uint256[] values,
    //     string[] signatures,
    //     bytes[] calldatas,
    //     uint256 startBlock,
    //     uint256 endBlock,
    //     string description
    // );

    // /// @notice An event emitted when a vote has been cast on a proposal
    // event VoteCast(
    //     address voter,
    //     uint256 proposalId,
    //     bool support,
    //     uint256 votes
    // );

    /// @notice An event emitted when a proposal has been canceled
    // event ProposalCanceled(uint256 id);

    // /// @notice An event emitted when a proposal has been queued in the Timelock
    // event ProposalQueued(uint256 id, uint256 eta);

    // /// @notice An event emitted when a proposal has been executed in the Timelock
    // eEvents.logProposalExecuted(uint256 id);

    // constructor(
    //     address timelock_,
    //     address sushi_,
    //     address guardian_
    // ) public {
    //     timelock = TimelockInterface(timelock_);
    //     sushi = SushiToken(sushi_);
    //     guardian = guardian_;
    // }

    function propose(
        Storage.State storage state,
        address[] memory targets,
        uint256[] memory values,
        string[] memory signatures,
        bytes[] memory calldatas,
        string memory description
    ) public returns (uint256) {
        // require(
        //     ISolar(state.getSolarAddress()).getPriorVotes(
        //         msg.sender,
        //         sub256(block.number, 1)
        //     ) > Constants.PROPOSAL_THRESHOLD,
        //     'GovernorAlpha::propose: proposer votes below proposal threshold'
        // );
        require(
            targets.length == values.length &&
                targets.length == signatures.length &&
                targets.length == calldatas.length,
            'GovernorAlpha::propose: proposal function information arity mismatch'
        );
        require(
            targets.length != 0,
            'GovernorAlpha::propose: must provide actions'
        );
        require(
            targets.length <= Constants.PROPOSAL_MAX_OPERATIONS,
            'GovernorAlpha::propose: too many actions'
        );

        uint256 latestProposalId = state.getLatestProposalIds(msg.sender);
        if (latestProposalId != 0) {
            Governance.ProposalState proposersLatestProposalState = getState(
                state,
                latestProposalId
            );
            require(
                proposersLatestProposalState != Governance.ProposalState.Active,
                'GovernorAlpha::propose: one live proposal per proposer, found an already active proposal'
            );
            require(
                proposersLatestProposalState !=
                    Governance.ProposalState.Pending,
                'GovernorAlpha::propose: one live proposal per proposer, found an already pending proposal'
            );
        }

        uint256 startBlock = add256(block.number, Constants.VOTING_DELAY);
        uint256 endBlock = add256(startBlock, Constants.VOTING_PERIOD);

        state.incrementProposalCount();
        // proposalCount++;
        Governance.Proposal memory newProposal = Governance.Proposal({
            id: state.getProposalCount(),
            proposer: msg.sender,
            eta: 0,
            targets: targets,
            values: values,
            signatures: signatures,
            calldatas: calldatas,
            startBlock: startBlock,
            endBlock: endBlock,
            forVotes: 0,
            againstVotes: 0,
            canceled: false,
            executed: false
        });

        // TODO: create setters or is this fine?
        state.governance.proposals[newProposal.id] = newProposal;
        state.governance.latestProposalIds[newProposal.proposer] = newProposal
            .id;

        Events.logProposalCreated(
            newProposal.id,
            msg.sender,
            targets,
            values,
            signatures,
            calldatas,
            startBlock,
            endBlock,
            description
        );
        return newProposal.id;
    }

    function queue(Storage.State storage state, uint256 proposalId) public {
        require(
            getState(state, proposalId) == Governance.ProposalState.Succeeded,
            'GovernorAlpha::queue: proposal can only be queued if it is succeeded'
        );
        Governance.Proposal memory proposal = state
            .governance
            .proposals[proposalId];
        uint256 eta = add256(
            block.timestamp,
            ITimeLock(state.getTimeLockAddress()).delay()
        );
        for (uint256 i = 0; i < proposal.targets.length; i++) {
            _queueOrRevert(
                state,
                proposal.targets[i],
                proposal.values[i],
                proposal.signatures[i],
                proposal.calldatas[i],
                eta
            );
        }
        proposal.eta = eta;
        Events.logProposalQueued(proposalId, eta);
    }

    function _queueOrRevert(
        Storage.State storage state,
        address target,
        uint256 value,
        string memory signature,
        bytes memory data,
        uint256 eta
    ) internal {
        require(
            ITimeLock(state.getTimeLockAddress()).queuedTransactions(
                keccak256(abi.encode(target, value, signature, data, eta))
            ),
            'GovernorAlpha::_queueOrRevert: proposal action already queued at eta'
        );
        ITimeLock(state.getTimeLockAddress()).queueTransaction(
            target,
            value,
            signature,
            data,
            eta
        );
    }

    function execute(Storage.State storage state, uint256 proposalId)
        public
        payable
    {
        require(
            getState(state, proposalId) == Governance.ProposalState.Queued,
            'GovernorAlpha::execute: proposal can only be executed if it is queued'
        );
        Governance.Proposal memory proposal = state.getProposal(proposalId);
        proposal.executed = true;
        for (uint256 i = 0; i < proposal.targets.length; i++) {
            ITimeLock(state.getTimeLockAddress()).executeTransaction.value(
                proposal.values[i]
            )(
                proposal.targets[i],
                proposal.values[i],
                proposal.signatures[i],
                proposal.calldatas[i],
                proposal.eta
            );
        }
        Events.logProposalExecuted(proposalId);
    }

    function cancel(Storage.State storage state, uint256 proposalId) public {
        Governance.ProposalState _state = getState(state, proposalId);
        require(
            _state != Governance.ProposalState.Executed,
            'GovernorAlpha::cancel: cannot cancel executed proposal'
        );

        Governance.Proposal memory proposal = state.getProposal[proposalId];
        require(
            msg.sender == state.getGuardianAddress() ||
                ISolar(state.getSolarAddress()).getPriorVotes(
                    proposal.proposer,
                    sub256(block.number, 1)
                ) <
                Constants.PROPOSAL_THRESHOLD,
            'GovernorAlpha::cancel: proposer above threshold'
        );

        proposal.canceled = true;
        for (uint256 i = 0; i < proposal.targets.length; i++) {
            ITimeLock(state.getTimeLockAddress()).cancelTransaction(
                proposal.targets[i],
                proposal.values[i],
                proposal.signatures[i],
                proposal.calldatas[i],
                proposal.eta
            );
        }

        Events.logProposalCanceled(proposalId);
    }

    function getActions(Storage.State storage state, uint256 proposalId)
        public
        view
        returns (
            address[] memory targets,
            uint256[] memory values,
            string[] memory signatures,
            bytes[] memory calldatas
        )
    {
        Governance.Proposal memory p = state.getProposal(proposalId);
        return (p.targets, p.values, p.signatures, p.calldatas);
    }

    function getReceipt(
        Storage.State storage state,
        uint256 proposalId,
        address voter
    ) public view returns (Governance.Receipt memory) {
        return state.getProposal(proposalId).receipts[voter];
    }

    function getState(Storage.State storage state, uint256 proposalId)
        public
        view
        returns (Governance.ProposalState)
    {
        require(
            state.getProposalCount() >= proposalId && proposalId > 0,
            'GovernorAlpha::state: invalid proposal id'
        );
        Governance.Proposal memory proposal = state.getProposal(
            proposalId
        )[proposalId];
        if (proposal.canceled) {
            return Governance.ProposalState.Canceled;
        } else if (block.number <= proposal.startBlock) {
            return Governance.ProposalState.Pending;
        } else if (block.number <= proposal.endBlock) {
            return Governance.ProposalState.Active;
        } else if (
            proposal.forVotes <= proposal.againstVotes ||
            proposal.forVotes < Constants.QORUM_VOTES
        ) {
            return Governance.ProposalState.Defeated;
        } else if (proposal.eta == 0) {
            return Governance.ProposalState.Succeeded;
        } else if (proposal.executed) {
            return Governance.ProposalState.Executed;
        } else if (
            block.timestamp >=
            add256(
                proposal.eta,
                ITimeLock(state.getTimeLockAddress()).GRACE_PERIOD()
            )
        ) {
            return Governance.ProposalState.Expired;
        } else {
            return Governance.ProposalState.Queued;
        }
    }

    function castVote(
        Storage.State storage state,
        uint256 proposalId,
        bool support
    ) public {
        return _castVote(msg.sender, proposalId, support);
    }

    function castVoteBySig(
        Storage.State storage state,
        uint256 proposalId,
        bool support,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public {
        bytes32 domainSeparator = keccak256(
            abi.encode(
                Governance.DOMAIN_TYPEHASH,
                keccak256(bytes('Sushi Governor Alpha')),
                getChainId(),
                address(this)
            )
        );
        bytes32 structHash = keccak256(
            abi.encode(Governance.BALLOT_TYPEHASH, proposalId, support)
        );
        bytes32 digest = keccak256(
            abi.encodePacked('\x19\x01', domainSeparator, structHash)
        );
        address signatory = ecrecover(digest, v, r, s);
        require(
            signatory != address(0),
            'GovernorAlpha::castVoteBySig: invalid signature'
        );
        return _castVote(state, signatory, proposalId, support);
    }

    function _castVote(
        Storage.State storage state,
        address voter,
        uint256 proposalId,
        bool support
    ) internal {
        require(
            getState(state, proposalId) == Governance.ProposalState.Active,
            'GovernorAlpha::_castVote: voting is closed'
        );
        Governance.Proposal memory proposal = state.getProposal(
            proposalId
        )[proposalId];
        Governance.Receipt memory receipt = proposal.receipts[voter];
        require(
            receipt.hasVoted == false,
            'GovernorAlpha::_castVote: voter already voted'
        );
        uint256 votes = ISolar(state.getSolarAddress()).getPriorVotes(
            voter,
            proposal.startBlock
        );

        if (support) {
            proposal.forVotes = add256(proposal.forVotes, votes);
        } else {
            proposal.againstVotes = add256(proposal.againstVotes, votes);
        }

        receipt.hasVoted = true;
        receipt.support = support;
        receipt.votes = votes;

        Events.logVoteCast(voter, proposalId, support, votes);
    }

    function __acceptAdmin(Storage.State storage state) public {
        require(
            msg.sender == state.getGuardianAddress(),
            'GovernorAlpha::__acceptAdmin: sender must be gov guardian'
        );
        ITimeLock(state.getTimeLockAddress()).acceptAdmin();
    }

    function __abdicate(Storage.State storage state) public {
        require(
            msg.sender == state.getGuardianAddress(),
            'GovernorAlpha::__abdicate: sender must be gov guardian'
        );
        state.governance.guardian = address(0);
    }

    function __queueSetTimelockPendingAdmin(
        Storage.State storage state,
        address newPendingAdmin,
        uint256 eta
    ) public {
        require(
            msg.sender == state.getGuardianAddress(),
            'GovernorAlpha::__queueSetTimelockPendingAdmin: sender must be gov guardian'
        );
        ITimeLock(state.getTimeLockAddress()).queueTransaction(
            address(state.getTimeLockAddress()),
            0,
            'setPendingAdmin(address)',
            abi.encode(newPendingAdmin),
            eta
        );
    }

    function __executeSetTimelockPendingAdmin(
        Storage.State storage state,
        address newPendingAdmin,
        uint256 eta
    ) public {
        require(
            msg.sender == state.getGuardianAddress(),
            'GovernorAlpha::__executeSetTimelockPendingAdmin: sender must be gov guardian'
        );
        ITimeLock(state.getTimeLockAddress()).executeTransaction(
            address(state.getTimeLockAddress()),
            0,
            'setPendingAdmin(address)',
            abi.encode(newPendingAdmin),
            eta
        );
    }

    function add256(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, 'addition overflow');
        return c;
    }

    function sub256(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, 'subtraction underflow');
        return a - b;
    }

    function getChainId() internal pure returns (uint256) {
        uint256 chainId;
        assembly {
            chainId := chainid()
        }
        return chainId;
    }
}
