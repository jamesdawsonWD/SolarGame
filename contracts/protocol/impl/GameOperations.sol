// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Events} from '../lib/Events.sol';
import {Storage} from '../lib/Storage.sol';
import {ITsuno} from '../interfaces/ITsuno.sol';
import {Battle} from '../lib/Battle.sol';

import {ISolar} from '../interfaces/ISolar.sol';
import {Types} from '../lib/Types.sol';
import {StarSystem} from '../lib/StarSystem.sol';
import {Fleet} from '../lib/Fleet.sol';

/**
 * @title Operation
 * @author Big Beluga
 *
 * Primary public function for entering into the protocol
 */
library GameOperations {
    using SafeMath for uint256;
    using Storage for Storage.State;

    // ============ Constants ============

    bytes32 constant FILE = 'GameOperations';

    function attack(
        Storage.State storage state,
        address attacker,
        address defender
    ) public {
        // Get the armies
        // Army.Info memory attackerArmy = Storage.getArmy(state, attacker);
        // Army.Info memory defenderArmy = Storage.getArmy(state, defender);
        // // TODO: convert string array to bytes32 array
        // // true = attackers, false = defenders
        // (bool result, bytes memory log) = Battle.attack(
        //     attackerArmy,
        //     defenderArmy
        // );
        // if (result) {
        //     uint256 reward = Storage.getBalance(state, defender).div(100).mul(
        //         80
        //     );
        //     Storage.addBalance(state, attacker, reward);
        //     Storage.subBalance(state, defender, reward);
        // } else {
        //     uint256 reward = Storage.getBalance(state, attacker).div(100).mul(
        //         40
        //     );
        //     Storage.addBalance(state, defender, reward);
        //     Storage.subBalance(state, attacker, reward);
        // }
        // Events.logBattle(attacker, defender, result, string(log));
    }

    function attackSolarSystem(
        Storage.State storage state,
        address attacker,
        uint256 solarSystem
    ) public {}

    function assignShipsToSolarSystem(
        Storage.State storage state,
        address attacker,
        uint256 solarSystem
    ) public {}

    function move(
        Storage.State storage state,
        Types.StarPosition memory from,
        Types.StarPosition memory to
    ) public {
        require(
            Types.isWithinBoundaries(to),
            'Position must be within set limits of the known universe'
        );
        require(
            Types.isEqualStarPosition(
                state.getMasterFleetPosition(msg.sender),
                to
            ),
            'You cannot move to your current location'
        );
        // address prevStarOwner = ISolar(state.solar).ownerOf(
        //     state.getTokenId(state, from)
        // );
        // if (prevStarOwner == msg.sender) {
        // }
        state.moveMasterFleet(msg.sender, to);
        // check if star has been explored
        if (state.getStarSystemType(to) == StarSystem.SystemType.Undiscovered) {
            // generate undiscovered star systems systemType
            StarSystem.SystemType systemType = StarSystem.randomSystemType();
            uint32 yield = StarSystem.randomYield(systemType);
            state.setStarSystemType(to, systemType);
            state.setStarSystemYield(to, yield);
            // Mint SolarSystem NFT to user so they can stake against it
            address solar = state.getSolar();
            uint256 _id = state.getTotalSolarTokens() + 1;
            ISolar(solar).mint(msg.sender, _id);
            // increment the total number of stars
            state.incrementTotalSolarTokens();
            return;
        }
        // check if mover is owner of starSystem
        // if (state.getStarSystemOwner(state, to) == msg.sender) {
        //     Fleet.Info memory masterFleet = state.getMasterFleet(
        //         state,
        //         msg.sender
        //     );
        // }
        // check if star has fleet
        if (state.getStarSystemHasFleet(to)) {
            Fleet.Info memory starFleet = state.getStarSystemFleet(to);
            Fleet.Info memory masterFleet = state.getMasterFleet(msg.sender);
            // if defenders are set to attack on sight, defenders go first
            if (starFleet.orders == Fleet.Orders.Attack) {
                // battle(starFleet, masterFleet);
            } else if (masterFleet.orders == Fleet.Orders.Attack) {
                // battle(masterFleet, starFleet);
            } else {
                // both sides are passive
                return;
            }
        }

        // I think we end here and we move a lot of this battle logic into seperate functions,
        // we can allow people to stack actions e.g [Move, Attack, Move, Defend] in one transaction
    }
}
