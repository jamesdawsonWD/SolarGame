// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {GameStorage} from './GameStorage.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Initializable} from '@openzeppelin/upgrades-core/contracts/Initializable.sol';
import {Types} from './lib/Types.sol';
import {Discovery} from './Discovery.sol';

import {ITreasury} from './interfaces/ITreasury.sol';

/**
 * @title Operation
 * @author Big Beluga
 *
 * Primary public function for entering into the protocol
 */
contract GameOperations is Initializable, Discovery {
    using SafeMath for uint256;

    // ============ Constants ============
    event LogMove(uint8 quadrant, uint8 district, uint8 sector, uint256 star);
    event LogStarSystemDiscovery(address indexed to, uint8 systemType);
    event Random(uint256 random);
    event TestUint(uint256 a, uint256 b);
    event BattleStarted(
        uint256 attackerOffense,
        uint256 attackerDefense,
        uint256 defenderOffense,
        uint256 defenderDefense
    );
    GameStorage GS;
    ITreasury TS;

    function initialize(address _gameStorage) public initializer {
        GS = GameStorage(_gameStorage);
        TS = ITreasury(GS.getTreasuryAddress());
    }

    function move(Types.Position memory to) public {
        require(
            Types.positionWithinBoundaries(to, GS.getBoundaries()),
            'Position must be within set limits of the known universe'
        );
        Types.Position memory from = GS.getMasterFleetPosition(msg.sender);

        if (Types.positionNotSet(from)) {
            from = GS.getStartPosition();
        }

        require(!Types.positionIsEqual(to, from), 'You cannot move to your current location');

        GS.setMasterFleetPosition(msg.sender, to);
        emit LogMove(to.quadrant, to.district, to.sector, to.star);

        if (GS.getStarSystemType(to) == Types.SystemType.Undiscovered) {
            explore(to);
        } // else if (state.getStarSystemHasFleet(to)) {
        // Fleet.Info memory starFleet = state.getStarSystemFleet(to);
        // Fleet.Info memory masterFleet = state.getMasterFleet(msg.sender);
        // // if defenders are set to attack on sight, defenders go first
        // if (starFleet.orders == Fleet.Orders.Attack) {
        //     // battle(starFleet, masterFleet);
        // } else if (masterFleet.orders == Fleet.Orders.Attack) {
        //     // battle(masterFleet, starFleet);
        // } else {
        //     // both sides are passive
        //     return;
        // }
        // }
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

    function withdrawMasterFleet(uint256[] memory _ships, uint256[] memory _amounts) public {
        removeMasterFleet(msg.sender, _ships, _amounts);
        TS.sendSats(msg.sender, _ships, _amounts);
    }

    function lockInMasterFleet(uint256[] memory _ships, uint256[] memory _amounts) public {
        updateMasterFleet(msg.sender, _ships, _amounts);
        TS.recieveSats(msg.sender, _ships, _amounts);
    }

    function attack(
        uint256 a_offense,
        uint256 a_defense,
        uint256 d_offense,
        uint256 d_defense
    ) public {
        // Get the armies
        emit BattleStarted(a_offense, a_defense, d_offense, d_defense);
        // TODO: convert string array to bytes32 array

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

    // function attackSolarSystem(
    //     Storage.State storage state,
    //     address attacker,
    //     uint256 solarSystem
    // ) public {}

    // function assignShipsToSolarSystem(
    //     Storage.State storage state,
    //     address attacker,
    //     uint256 solarSystem
    // ) public {}

    function explore(Types.Position memory star) private {
        (Types.SystemType systemType, uint256 rand) = GS.getRandomSystemType();
        GS.setStarSystemType(star, systemType);
        emit LogStarSystemDiscovery(msg.sender, uint8(systemType));

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
        (uint256 a_offense, uint256 a_defense) = GS.getMasterFleetInfo(msg.sender);
        (uint256 d_offense, uint256 d_defense) = GS.getAiFleetInfo(
            Types.SystemType.AlienFleetAggressive
        );

        attack(a_offense, a_defense, d_offense, d_defense);
        if (systemType == Types.SystemType.Empty) {
            // There is nothing here.
            return;
        } else if (
            systemType == Types.SystemType.AncientFleetAggressive ||
            systemType == Types.SystemType.AdvancedAlienFleetAggressive ||
            systemType == Types.SystemType.AlienFleetAggressive
        ) {
            // generate fleet and technology with ancient being the strongest andsoftfisting alien being the weakest
        } else if (
            systemType == Types.SystemType.LowYieldSystem ||
            systemType == Types.SystemType.MediumYieldSystem ||
            systemType == Types.SystemType.HighYieldSystem ||
            systemType == Types.SystemType.InsaneYieldSystem
        ) {} else if (systemType == Types.SystemType.SuperComputerEvent) {
            uint16 yield = GS.getRandomYield(systemType);
            GS.setStarSystemYield(star, yield);
            TS.mintFhr(msg.sender, GS.incrementTotalFhr());
        } else if (systemType == Types.SystemType.ShipWreck) {
            uint256 multiplier = rand.mod(2) == 0 ? 2 : 1;
            Types.SatInfo memory ship = Discovery.singleAllNonAncientShips();
            uint256[] memory ships = new uint256[](1);
            uint256[] memory amounts = new uint256[](1);
            ships[0] = ship.id;
            amounts[0] = ship.amount.mul(multiplier);
            TS.sendSats(msg.sender, ships, amounts);
            updateMasterFleet(msg.sender, ships, amounts);
        } else if (systemType == Types.SystemType.AncientMiningSystem) {
            Types.SatInfo memory ship = Discovery.singleAncientMiningShip();
            uint256[] memory ships = new uint256[](1);
            uint256[] memory amounts = new uint256[](1);
            ships[0] = ship.id;
            amounts[0] = ship.amount;
            TS.sendSats(msg.sender, ships, amounts);
            updateMasterFleet(msg.sender, ships, amounts);
        }
    }

    function updateMasterFleet(
        address _master,
        uint256[] memory _ids,
        uint256[] memory _amounts
    ) internal {
        uint256 offense;
        uint256 defense;
        for (uint256 i = 0; i < _ids.length; i++) {
            (uint256 o, uint256 d) = GS.getSatInfo(Types.ShipAndTechList(_ids[i]));
            TestUint(o, d);
            GS.setMasterLockedInShipInfo(_master, _ids[i], _amounts[i]);
            offense += o.mul(_amounts[i]);
            defense += d.mul(_amounts[i]);
            TestUint(offense, defense);
        }
        GS.setMasterFleetOffense(_master, offense);
        GS.setMasterFleetDefense(_master, defense);
        emit TestUint(offense, defense);
    }

    function removeMasterFleet(
        address _master,
        uint256[] memory _ids,
        uint256[] memory _amounts
    ) internal {
        uint256 offense;
        uint256 defense;
        for (uint256 i = 0; i < _ids.length; i++) {
            (uint256 o, uint256 d) = GS.getSatInfo(Types.ShipAndTechList(_ids[i]));
            uint256 lockedIn = GS.getMasterLockedInShipInfo(_master, _ids[i]);
            require(lockedIn != 0, 'This ship ID has not been locked in');
            require(lockedIn >= _amounts[i], 'Amount requested is greater than locked into fleet');
            GS.setMasterLockedInShipInfo(_master, _ids[i], lockedIn.sub(_amounts[i]));
            offense += o.mul(_amounts[i]);
            defense += d.mul(_amounts[i]);
        }

        uint256 currentOffense = GS.getMasterFleetOffense(_master);
        uint256 currentDefense = GS.getMasterFleetDefense(_master);
        require(
            currentOffense >= offense && currentDefense >= defense,
            'The amount is greater than your current fleet'
        );
        GS.setMasterFleetOffense(_master, currentOffense.sub(offense));
        GS.setMasterFleetDefense(_master, currentDefense.sub(defense));
    }
}
