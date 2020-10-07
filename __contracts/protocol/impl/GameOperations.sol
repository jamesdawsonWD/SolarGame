// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Events} from '../lib/Events.sol';
import {Storage} from '../lib/Storage.sol';
import {Battle} from '../lib/Battle.sol';
import {Types} from '../lib/Types.sol';
import {StarSystem} from '../lib/StarSystem.sol';
import {Fleet} from '../lib/Fleet.sol';
import {Constants} from '../lib/Constants.sol';
import {Discover} from '../lib/Discover.sol';
import {SATs} from '../lib/SATs.sol';

// Interfaces
import {ISolar} from '../interfaces/ISolar.sol';
import {IFHR} from '../interfaces/IFHR.sol';
import {ISat} from '../interfaces/ISat.sol';

/**
 * @title Operation
 * 4@author Big Beluga
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

    function explore(
        Storage.State storage state,
        Types.StarPosition memory star
    ) private {
        (StarSystem.SystemType systemType, uint256 rand) = StarSystem
            .randomSystemType();
        state.setStarSystemType(star, systemType);
        Events.logStarSystemDiscovery(msg.sender, systemType);

        address sat = state.getSATsAddress();

        // AncientFleetAggressive,
        // SuperComputerEvent,
        // AdvancedAlienFleetAggressive,
        // AiFleetAggressive,
        // AlienFleetAggressive,
        // PiratesEvent,
        // SolarWinds,
        // Asteroids,
        // Empty,
        // GovermentOwned,
        // LowYieldSystem,
        // RandomEvent,
        // MediumYieldSystem,
        // ShipWreck,
        // HighYieldSystem,
        // AncientMiningSystem,
        // AncientWeaponSystem,
        // AncientShipWreck,
        // InsaneYieldSystem,
        // AncientRacePassive
        if (systemType == StarSystem.SystemType.Empty) {
            // There is nothing here.
            return;
        } else if (
            systemType == StarSystem.SystemType.AncientFleetAggressive ||
            systemType == StarSystem.SystemType.AdvancedAlienFleetAggressive ||
            systemType == StarSystem.SystemType.AiFleetAggressive ||
            systemType == StarSystem.SystemType.AlienFleetAggressive
        ) {
            // generate fleet and technology with ancient being the strongest and alien being the weakest
        } else if (
            systemType == StarSystem.SystemType.LowYieldSystem ||
            systemType == StarSystem.SystemType.MediumYieldSystem ||
            systemType == StarSystem.SystemType.HighYieldSystem ||
            systemType == StarSystem.SystemType.InsaneYieldSystem
        ) {
            uint16 yield = StarSystem.randomYield(systemType);
            state.setStarSystemYield(star, yield);
            address fhr = state.getFhrAddress();
            uint256 _id = state.getTotalFhrTokens() + 1;
            IFHR(fhr).mint(msg.sender, _id);
            Events.logRandom(state.incrementTotalFhrTokens());
        } else if (systemType == StarSystem.SystemType.SuperComputerEvent) {
            // do event by pushing the event type to a mapping of the senders address and event type
            // which will contain the criteria of the event
        } else if (systemType == StarSystem.SystemType.ShipWreck) {
            uint256 multiplier = rand % 2 == 0 ? 2 : 1;
            SATs.Info memory ship = Discover.singleAllNonAncientShips();

            ISat(sat).safeTransferFrom(
                address(this),
                msg.sender,
                ship.id,
                ship.amount * multiplier,
                ''
            );
        } else if (systemType == StarSystem.SystemType.AncientMiningSystem) {
            SATs.Info memory ship = Discover.singleAncientMiningShip();

            ISat(sat).safeTransferFrom(
                address(this),
                msg.sender,
                ship.id,
                ship.amount,
                ''
            );
        }
    }

    function move(
        Storage.State storage state,
        Types.StarPosition memory ye,
        Types.StarPosition memory to
    ) public {
        require(
            Types.isWithinBoundaries(to),
            'Position must be within set limits of the known universe'
        );
        Types.StarPosition memory from = state.getMasterFleetPosition(
            msg.sender
        );

        if (Types.notSet(from)) {
            from = Types.StarPosition({
                quadrant: Constants.START_POSITION_QUADRANT,
                distract: Constants.START_POSITION_DISTRACT,
                sector: Constants.START_POSITION_SECTOR,
                star: Constants.START_POSITION_STAR
            });
        }

        require(
            !Types.isEqual(to, from),
            'You cannot move to your current location'
        );

        state.moveMasterFleet(msg.sender, to);
        Events.logMove(to.quadrant, to.distract, to.sector, to.star);

        if (state.getStarSystemType(to) == StarSystem.SystemType.Undiscovered) {
            explore(state, to);
        } else if (state.getStarSystemHasFleet(to)) {
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
        // check if mover is owner of starSystem
        // if (state.getStarSystemOwner(state, to) == msg.sender) {
        //     Fleet.Info memory masterFleet = state.getMasterFleet(
        //         state,
        //         msg.sender
        //     );
        // }
        // check if star has fleet

        // I think we end here and we move a lot of this battle logic into seperate functions,
        // we can allow people to stack actions e.g [Move, Attack, Move, Defend] in one transaction
    }
}
