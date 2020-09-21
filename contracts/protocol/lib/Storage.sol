pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Math} from './Math.sol';
import {Require} from './Require.sol';
import {Samurai} from './Samurai.sol';
import {Army} from './Army.sol';

/**
 * @title Storage
 * @author Big Beluga
 *
 * Functions for reading, writing, and verifying state in Oppo
 */
library Storage {
    using Storage for Storage.State;
    using Math for uint256;
    using SafeMath for uint256;

    // ============ Constants ============

    bytes32 constant FILE = 'Storage';

    // // ============ Structs ============

    // The entire storage state

    struct Master {
        uint256 balance;
        uint256 dateLocked;
        uint256 dateUnlocked;
        uint256 reward;
        Army.Info army;
    }

    struct State {
        mapping(address => Master) masters;
        mapping(uint256 => address) samuraiIndexToOwner;
        uint256 totalClans;
        uint256 totalSamurai;
        uint256 tsunoLocked;
        Samurai.Info[] samurai;
        address admin;
        uint256 seed;
        uint256 bonusEndBlock;
        uint256 tsunoPerBlock;
        address tsunoAddress;
        uint256 lastRewardBlock;
        address tsuno;
    }

    // ============ Functions ============

    function getBalance(Storage.State storage state, address master)
        internal
        view
        returns (uint256)
    {
        return state.masters[master].balance;
    }

    function getTsuno(Storage.State storage state)
        internal
        view
        returns (address)
    {
        return state.tsuno;
    }

    function getArmy(Storage.State storage state, address master)
        internal
        view
        returns (Army.Info memory)
    {
        return state.masters[master].army;
    }

    function getDateLocked(Storage.State storage state, address master)
        internal
        view
        returns (uint256)
    {
        return state.masters[master].dateLocked;
    }

    function getDateUnlocked(Storage.State storage state, address master)
        internal
        view
        returns (uint256)
    {
        return state.masters[master].dateUnlocked;
    }

    function getReward(Storage.State storage state, address master)
        internal
        view
        returns (uint256)
    {
        return state.masters[master].reward;
    }

    function getLastRewardBlock(Storage.State storage state)
        internal
        view
        returns (uint256)
    {
        return state.lastRewardBlock;
    }

    function isWithdrawable(Storage.State storage state, address master)
        internal
        returns (bool)
    {
        return now >= state.masters[master].dateUnlocked;
    }

    // =============== Setter Functions ===============

    function setSeed(Storage.State storage state, uint256 seed) internal {
        state.seed = seed;
    }

    function setTsunoLocked(Storage.State storage state, uint256 amount)
        internal
    {
        state.tsunoLocked = amount;
    }

    // =============== Mutation Functions ==============

    function subBalance(
        Storage.State storage state,
        address master,
        uint256 amount
    ) internal {
        state.masters[master].balance = state.masters[master].balance.sub(
            amount
        );
    }

    function addBalance(
        Storage.State storage state,
        address master,
        uint256 amount
    ) internal {
        state.masters[master].balance = state.masters[master].balance.add(
            amount
        );
    }

    function lockinTsuno(
        Storage.State storage state,
        address master,
        uint256 amount,
        uint256 time,
        uint256 reward
    ) internal {
        state.masters[master].balance += amount;
        state.masters[master].dateUnlocked = now + time * 1 days;
        state.masters[master].reward = reward;
    }

    function unlockTsuno(Storage.State storage state, address master) internal {
        state.masters[master].balance = 0;
        state.masters[master].dateUnlocked = 0;
        state.masters[master].reward = 0;
    }

    // =============== Army Functions ==============

    function addSolider(
        Storage.State storage state,
        address master,
        uint256 amount
    ) internal {
        state.masters[master].army.soldiers = state.masters[master]
            .army
            .soldiers
            .add(amount);
    }

    function addUnit(
        Storage.State storage state,
        Army.Units unit,
        address master,
        uint256 amount
    ) internal {
        if (unit == Army.Units.SiegeWeapon) {
            state.masters[master].army.siegeWeapons = state.masters[master]
                .army
                .siegeWeapons
                .add(amount);
        } else if (unit == Army.Units.DefenseStructure) {
            state.masters[master].army.defenceStructures = state.masters[master]
                .army
                .defenceStructures
                .add(amount);
        } else if (unit == Army.Units.Soldier) {
            state.masters[master].army.soldiers = state.masters[master]
                .army
                .soldiers
                .add(amount);
        } else if (unit == Army.Units.Archer) {
            state.masters[master].army.archers = state.masters[master]
                .army
                .archers
                .add(amount);
        } else if (unit == Army.Units.Cavalry) {
            state.masters[master].army.cavalry = state.masters[master]
                .army
                .cavalry
                .add(amount);
        }
    }

    function subUnit(
        Storage.State storage state,
        Army.Units unit,
        address master,
        uint256 amount
    ) internal {
        if (unit == Army.Units.SiegeWeapon) {
            state.masters[master].army.siegeWeapons = state.masters[master]
                .army
                .siegeWeapons
                .sub(amount);
        } else if (unit == Army.Units.DefenseStructure) {
            state.masters[master].army.defenceStructures = state.masters[master]
                .army
                .defenceStructures
                .sub(amount);
        } else if (unit == Army.Units.Soldier) {
            state.masters[master].army.soldiers = state.masters[master]
                .army
                .soldiers
                .sub(amount);
        } else if (unit == Army.Units.Archer) {
            state.masters[master].army.archers = state.masters[master]
                .army
                .archers
                .sub(amount);
        } else if (unit == Army.Units.Cavalry) {
            state.masters[master].army.cavalry = state.masters[master]
                .army
                .cavalry
                .sub(amount);
        }
    }
}
