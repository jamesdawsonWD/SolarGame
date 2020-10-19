// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {GameStorage} from './GameStorage.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Initializable} from '@openzeppelin/upgrades-core/contracts/Initializable.sol';
import {Types} from './lib/Types.sol';
import {Discovery} from './Discovery.sol';
import {ITreasury} from './interfaces/ITreasury.sol';
import {IFHR} from './interfaces/IFHR.sol';
import {ISolar} from './interfaces/ISolar.sol';
import {ISat} from './interfaces/ISat.sol';
import {PlanetManager} from './PlanetManager.sol';
import {GameStorage} from './GameStorage.sol';

/**
 * @title Operation
 * @author Big Beluga
 *
 * Primary public function for entering into the protocol
 */
contract GameOperations is Initializable, Discovery {
    using SafeMath for uint256;
    IFHR fhr;
    ISolar solar;
    ISat sats;
    PlanetManager pm;
    // ============ Constants ============
    event LogMove(uint8 quadrant, uint8 district, uint8 sector, uint256 star);
    event LogStarSystemDiscovery(address indexed to, uint8 systemType);
    event LogBattle(bool result, uint256 attackersHealth, uint256 defendersHealth);
    event Random(uint256 random);
    event LogRound(uint256 aDamage, uint256 dDamage, uint256 aHealth, uint256 dHealth);
    event BattleStarted(
        address attacker,
        uint256 attackerOffense,
        uint256 attackerDefense,
        address defender,
        uint256 defenderOffense,
        uint256 defenderDefense
    );

    struct AttackInfo {
        Types.Position attackerPos;
        uint256 a_offense;
        uint256 a_defense;
        uint256[] a_balances;
        uint256[] a_ids;
        Types.Position defenderPos;
        uint256 d_offense;
        uint256 d_defense;
        uint256[] d_balances;
        uint256[] d_ids;
        uint256[] d_retreated;
    }

    GameStorage GS;
    ITreasury TS;

    function initialize(address _gameStorage) public initializer {
        GS = GameStorage(_gameStorage);
        TS = ITreasury(GS.getTreasuryAddress());
        fhr = IFHR(GS.getFhrAddress());
        solar = ISolar(GS.getSolarAddress());
        sats = ISat(GS.getSatAddress());
        pm = PlanetManager(GS.getPlanetManagerAddress());
    }

    function withdrawMasterFleet(uint256[] memory _ships, uint256[] memory _amounts) public {
        // removeMasterFleet(msg.sender, _ships, _amounts);
        TS.sendSats(msg.sender, _ships, _amounts);
    }

    function lockInMasterFleet(uint256[] memory _ships, uint256[] memory _amounts) public {
        // updateMasterFleet(msg.sender, _ships, _amounts);
        TS.recieveSats(msg.sender, _ships, _amounts);
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
        }
    }

    function battle(
        uint256 a_offense,
        uint256 a_health,
        uint256 d_offense,
        uint256 d_health,
        bool defenderGoesFirst,
        uint8 turns
    ) internal returns (bool result) {
        uint256 turnThreshold = 10;
        uint256 attackerAttack = uint256(
            a_offense.div(turnThreshold) != 0 ? a_offense.div(turnThreshold) : 1
        );
        uint256 defenderAttack = uint256(
            d_offense.div(turnThreshold) != 0 ? d_offense.div(turnThreshold) : 1
        );

        uint256 nonce = attackerAttack * defenderAttack;
        uint256 damageD;
        uint256 damageA;
        for (uint8 i = 0; i < turns; i++) {
            if (defenderGoesFirst) {
                damageD = randomrange(1, defenderAttack);
                damageA = randomrange(1, attackerAttack);
                emit LogRound(damageA, damageD, a_health, d_health);
                a_health = a_health > damageD ? a_health.sub(damageD) : 0;
                d_health = d_health > damageA ? d_health.sub(damageA) : 0;
            } else {
                damageD = randomrange(1, defenderAttack);
                damageA = randomrange(1, attackerAttack);
                d_health = d_health > damageA ? d_health.sub(damageA) : 0;
                a_health = a_health > damageD ? a_health.sub(damageD) : 0;
            }
            if (a_health == 0 || d_health == 0) break;
        }

        // the result is true if the attacker wins and false if the defender wins
        result = a_health > d_health;

        emit LogBattle(result, a_health, d_health);
    }

    function calculateStats(address fleet)
        internal
        returns (
            uint256 offense,
            uint256 defense,
            uint256[] memory balances,
            uint256[] memory ids
        )
    {
        ids = new uint256[](GS.getTotalSats());
        address[] memory accounts = new address[](ids.length);
        for (uint256 i = 0; i < ids.length; i++) {
            ids[i] = i;
            accounts[i] = fleet;
        }
        balances = sats.balanceOfBatch(accounts, ids);
        (uint256[] memory offenses, uint256[] memory defenses) = GS.batchGetSatInfo(ids);
        for (uint256 i = 0; i < balances.length; i++) {
            (uint256 o, uint256 d) = (offenses[i], defenses[i]);
            offense += o.mul(balances[i]);
            defense += d.mul(balances[i]);
        }
    }

    function attack(address defender, uint8 turns) public {
        require(defender != msg.sender, 'You cannot attack yourself');
        require(
            defender != address(0) && msg.sender != address(0),
            'Addresses must exist must exist'
        );
        AttackInfo memory info;

        info.attackerPos = GS.getMasterFleetPosition(msg.sender);
        info.defenderPos = GS.getMasterFleetPosition(defender);

        require(
            Types.positionIsEqual(info.attackerPos, info.defenderPos),
            'You can only attack people at your current star location'
        );

        (info.a_offense, info.a_defense, info.a_balances, info.a_ids) = calculateStats(msg.sender);
        (info.d_offense, info.d_defense, info.d_balances, info.d_ids) = calculateStats(defender);

        emit BattleStarted(
            msg.sender,
            info.a_offense,
            info.a_defense,
            defender,
            info.d_offense,
            info.d_defense
        );
        bool result = battle(
            info.a_offense,
            info.a_defense,
            info.d_offense,
            info.d_defense,
            true,
            turns
        );

        if (result) {
            for (uint256 i = 0; i < info.a_balances.length; i++) {
                info.a_balances[i] = info.a_balances[i] > 0
                    ? info.a_balances[i].mul(20).div(100)
                    : 0; // 20% of attackers fleet is lost in a successful attack
            }
            TS.recieveSats(msg.sender, info.a_ids, info.a_balances);

            info.d_retreated = new uint256[](info.d_balances.length);
            for (uint256 i = 0; i < info.d_balances.length; i++) {
                // 70% of defenders fleet is lost in a successful attack
                uint256 losses = info.d_balances[i].mul(70).div(100);
                info.d_balances[i] = info.d_balances[i] > 0 ? losses : 0;
                info.d_retreated[i] = info.d_balances[i] > losses
                    ? info.d_balances[i].sub(losses)
                    : 0;
            }

            uint256 _tokenId = GS.getProxyAddressToTokenId(defender);
            if (_tokenId > 0) {
                // the remaining fleet managed to escape back to command
                // while destroying the mining equipment
                address owner = fhr.ownerOf(_tokenId);
                TS.sendSats(owner, info.d_ids, info.d_retreated);
                TS.transferFhr(owner, msg.sender, _tokenId);
            }
            TS.recieveSats(defender, info.d_ids, info.d_balances);
        } else {
            for (uint256 i = 0; i < info.a_balances.length; i++) {
                info.a_balances[i] = info.a_balances[i] > 0
                    ? info.a_balances[i].mul(90).div(100)
                    : 0; // 20% of attackers fleet is lost in a successful attack
            }
            TS.recieveSats(msg.sender, info.a_ids, info.a_balances);

            info.d_retreated = new uint256[](info.d_balances.length);
            for (uint256 i = 0; i < info.d_balances.length; i++) {
                // 70% of defenders fleet is lost in a successful attack
                uint256 losses = info.d_balances[i].mul(10).div(100);
                info.d_balances[i] = info.d_balances[i] > 0 ? losses : 0;
                info.d_retreated[i] = info.d_balances[i] > losses
                    ? info.d_balances[i].sub(losses)
                    : 0;
            }

            TS.recieveSats(defender, info.d_ids, info.d_balances);
        }

        // // if false the defender has won
        // else {
        // uint256 a_actualBalance;
        // for (uint256 i = 0; i < a_balances.length; i++) {
        //     if (a_balances[i] > 0) a_actualBalance++;
        // }
        // uint256[] memory a_ids = new uint256[](a_actualBalance);
        // uint256[] memory a_amounts = new uint256[](a_actualBalance);
        // uint256 a_pos = 0;
        // for (uint256 i = 0; i < a_balances.length; i++) {
        //     if (a_balances[i] > 0) {
        //         _ids[pos] = i;
        //         _amounts[pos] = a_balances[i].mul(20).div(100); // 20% of attackers fleet is lost in a successful attack
        //         pos++;
        //     }
        // }
        // TS.recieveSats(msg.sender, a_ids, a_amounts);

        // uint256 d_actualBalance;
        // for (uint256 i = 0; i < a_balances.length; i++) {
        //     if (a_balances[i] > 0) d_actualBalance++;
        // }
        // uint256[] memory d_ids = new uint256[](d_actualBalance);
        // uint256[] memory d_amounts = new uint256[](d_actualBalance);
        // uint256 d_pos = 0;
        // for (uint256 i = 0; i < a_balances.length; i++) {
        //     if (a_balances[i] > 0) {
        //         _ids[pos] = i;
        //         _amounts[pos] = a_balances[i].mul(70).div(100); // 70% of defenders fleet is lost in a successful attack
        //         pos++;
        //     }
        // }
        // TS.recieveSats(msg.sender, d_ids, d_amounts);

        // uint256 _tokenId = GS.getProxyAddressToTokenId(defender);
        // if (_tokenId > 0) {
        //     address owner = fhr.ownerOf(_tokenId);
        //     TS.transferFhr(owner, msg.sender, _tokenId);
        // }
        // }
        // if result is true then attacker has won
        // if (result) {}
        // find out who won
        // reduce both fleets
        // reward the victor either with solar or NFT
    }

    function explore(Types.Position memory star) internal {
        (Types.SystemType systemType, uint256 rand) = Discovery.randomSystemType();
        GS.setStarSystemType(star, systemType);
        emit LogStarSystemDiscovery(msg.sender, uint8(systemType));

        if (systemType == Types.SystemType.Empty) {
            // There is nothing here.
            return;
        } else if (
            systemType == Types.SystemType.AncientFleetAggressive ||
            systemType == Types.SystemType.AdvancedAlienFleetAggressive ||
            systemType == Types.SystemType.AlienFleetAggressive
        ) {
            (uint256 a_offense, uint256 a_defense) = GS.getAiFleetInfo(systemType);
            (
                uint256 d_offense,
                uint256 d_defense,
                uint256[] memory d_balances,
                uint256[] memory d_ids
            ) = calculateStats(msg.sender);

            emit BattleStarted(
                msg.sender,
                a_offense,
                a_defense,
                address(this),
                d_offense,
                d_defense
            );
            bool result = battle(a_offense, a_defense, d_offense, d_defense, true, 10);
        } else if (
            systemType == Types.SystemType.LowYieldSystem ||
            systemType == Types.SystemType.MediumYieldSystem ||
            systemType == Types.SystemType.HighYieldSystem ||
            systemType == Types.SystemType.InsaneYieldSystem
        ) {
            (uint256 low, uint256 high) = GS.getStarSystemYieldRange(systemType);
            uint256 yield = randomrange(low, high);
            uint256 _id = GS.incrementTotalFhr();
            TS.mintFhr(msg.sender, _id);
            address _address = pm.createPlanet(
                _id,
                abi.encodeWithSignature(
                    'initialize(address,address,address,address,uint256,uint256)',
                    address(pm),
                    address(solar),
                    address(fhr),
                    address(sats),
                    yield,
                    _id
                )
            );
            GS.setMasterFleetPosition(_address, star);
            GS.setTokenIdToProxyAddress(_id, _address);
            GS.setProxyAddressToTokenId(_id, _address);
        } else if (systemType == Types.SystemType.ShipWreck) {
            uint256 multiplier = rand.mod(2) == 0 ? 2 : 1;
            Types.SatInfo memory ship = Discovery.singleAllNonAncientShips();
            uint256[] memory ships = new uint256[](1);
            uint256[] memory amounts = new uint256[](1);
            ships[0] = ship.id;
            amounts[0] = ship.amount.mul(multiplier);
            TS.sendSats(msg.sender, ships, amounts);
        } else if (systemType == Types.SystemType.AncientMiningSystem) {
            Types.SatInfo memory ship = Discovery.singleAncientMiningShip();
            uint256[] memory ships = new uint256[](1);
            uint256[] memory amounts = new uint256[](1);
            ships[0] = ship.id;
            amounts[0] = ship.amount;
            TS.sendSats(msg.sender, ships, amounts);
        }
    }
}
