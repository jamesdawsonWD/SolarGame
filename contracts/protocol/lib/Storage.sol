pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Math} from './Math.sol';
import {Require} from './Require.sol';
import {StarSystem} from './StarSystem.sol';
import {Types} from './Types.sol';
import {Fleet} from './Fleet.sol';

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

    struct Master {
        uint256 balance;
        uint256 dateLocked;
        uint256 dateUnlocked;
        uint256 reward;
        Types.StarPosition position;
        Fleet.Info fleet;
    }

    struct State {
        mapping(address => Master) masters;
        // total number of discoverable locations in the galaxy
        mapping(uint8 => mapping(uint8 => mapping(uint8 => mapping(uint32 => StarSystem.Info)))) stars;
        // total number of SolarTokens
        uint256 totalSolarTokens;
        // a random seed that can be set by an admin
        uint256 seed;
        // address to the tsunoToken contract
        address tsuno;
        // address to the solarToken contract
        address solar;
        // address of ships and technology contract;
        address sat;
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

    function getSolar(Storage.State storage state)
        internal
        view
        returns (address)
    {
        return state.solar;
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

    function getTotalSolarTokens(Storage.State storage state)
        internal
        view
        returns (uint256)
    {
        return state.totalSolarTokens;
    }

    function getStarSystemType(
        Storage.State storage state,
        Types.StarPosition memory position
    ) internal returns (StarSystem.SystemType) {
        return
            state.stars[position.quadrant][position.distract][position
                .sector][position.star]
                .systemType;
    }

    function getStarSystemFleet(
        Storage.State storage state,
        Types.StarPosition memory position
    ) internal returns (Fleet.Info memory) {
        return
            state.stars[position.quadrant][position.distract][position
                .sector][position.star]
                .fleet;
    }

    function getStarSystemHasFleet(
        Storage.State storage state,
        Types.StarPosition memory position
    ) internal returns (bool) {
        return
            state.stars[position.quadrant][position.distract][position
                .sector][position.star]
                .hasFleet;
    }

    function getStarSystemYield(
        Storage.State storage state,
        Types.StarPosition memory position
    ) internal returns (uint32) {
        return
            state.stars[position.quadrant][position.distract][position
                .sector][position.star]
                .yield;
    }

    function getStarSystemInvestment(
        Storage.State storage state,
        Types.StarPosition memory position
    ) internal returns (uint256) {
        return
            state.stars[position.quadrant][position.distract][position
                .sector][position.star]
                .investment;
    }

    function getStarSystemId(
        Storage.State storage state,
        Types.StarPosition memory position
    ) internal returns (uint256) {
        return
            state.stars[position.quadrant][position.distract][position
                .sector][position.star]
                .tokenId;
    }

    function getMasterFleet(Storage.State storage state, address master)
        internal
        returns (Fleet.Info memory)
    {
        return state.masters[master].fleet;
    }

    function isWithdrawable(Storage.State storage state, address master)
        internal
        returns (bool)
    {
        return now >= state.masters[master].dateUnlocked;
    }

    function getMasterFleetPosition(Storage.State storage state, address master)
        internal
        returns (Types.StarPosition memory)
    {
        return state.masters[master].position;
    }

    // =============== Setter Functions ===============

    function setSeed(Storage.State storage state, uint256 seed) internal {
        state.seed = seed;
    }

    function setStarSystemType(
        Storage.State storage state,
        Types.StarPosition memory position,
        StarSystem.SystemType systemType
    ) internal {
        state.stars[position.quadrant][position.distract][position
            .sector][position.star]
            .systemType = systemType;
    }

    function setStarSystemYield(
        Storage.State storage state,
        Types.StarPosition memory position,
        uint32 yield
    ) internal {
        state.stars[position.quadrant][position.distract][position
            .sector][position.star]
            .yield = yield;
    }

    function incrementTotalSolarTokens(Storage.State storage state) internal {
        state.totalSolarTokens += 1;
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

    // =============== Fleet Functions ==============

    function moveMasterFleet(
        Storage.State storage state,
        address master,
        Types.StarPosition memory position
    ) internal {
        //TODO: check each variable of starPosition to save gas on writing
        state.masters[master].fleet.position = position;
    }

    function addToMasterFleet(
        Storage.State storage state,
        address master,
        Types.SatInfo[] memory sats
    ) internal {
        for (uint256 i = 0; i < sats.length; i++) {
            state.masters[master].fleet.shipsAndTechnology[sats[i]
                .id] += sats[i].amount;
        }
    }

    function removeFromMasterFleet(
        Storage.State storage state,
        address master,
        Types.SatInfo[] memory sats
    ) internal {
        for (uint256 i = 0; i < sats.length; i++) {
            state.masters[master].fleet.shipsAndTechnology[sats[i]
                .id] -= sats[i].amount;
        }
    }

    function addToStarFleet(
        Storage.State storage state,
        Types.StarPosition memory position,
        Types.SatInfo[] memory sats
    ) internal {
        for (uint256 i = 0; i < sats.length; i++) {
            state.stars[position.quadrant][position.distract][position
                .sector][position.star]
                .fleet
                .shipsAndTechnology[sats[i].id] += sats[i].amount;
        }
    }

    function removeFromStarFleet(
        Storage.State storage state,
        Types.StarPosition memory position,
        Types.SatInfo[] memory sats
    ) internal {
        for (uint256 i = 0; i < sats.length; i++) {
            state.stars[position.quadrant][position.distract][position
                .sector][position.star]
                .fleet
                .shipsAndTechnology[sats[i].id] -= sats[i].amount;
        }
    }
}
