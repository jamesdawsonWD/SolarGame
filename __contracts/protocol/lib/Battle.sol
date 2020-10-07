// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Random} from './Random.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Strings} from './Strings.sol';

/**
 * @title Exchange
 * @author Big Beluga
 *
 * Library for transferring tokens and interacting with ExchangeWrappers by using the Wei struct
 */
library Battle {
    using SafeMath for uint256;
    // ============ Constants ============

    bytes32 constant FILE = 'Battle';

    // ============ Library Functions ============

    // function attack(Army.Info memory attacker, Army.Info memory defender)
    //     internal
    //     returns (bool winner, bytes memory log)
    // {
    //     // Defender always goes first
    //     uint256 attackerHealth = calculateArmyHealth(attacker);
    //     uint256 defenderHealth = calculateArmyHealth(defender);

    //     log = abi.encodePacked(
    //         'Attacker Starting Health: ',
    //         Strings.stringify(attackerHealth),
    //         ',Defender Starting Health: ',
    //         Strings.stringify(defenderHealth)
    //     );

    //     for (uint256 i = 0; i < TURNS; i++) {
    //         if (defender.siegeWeapons > 0) {
    //             attacker = siegeWeaponDamage(attacker, defender.siegeWeapons);
    //         }

    //         if (attacker.siegeWeapons > 0) {
    //             defender = siegeWeaponDamage(defender, attacker.siegeWeapons);
    //         }

    //         if (defender.cavalry > 0) {
    //             attacker = cavalryDamage(attacker, defender.cavalry);
    //         }
    //         if (attacker.cavalry > 0) {
    //             defender = cavalryDamage(defender, attacker.cavalry);
    //         }

    //         if (defender.archers > 0) {
    //             attacker = archerDamage(attacker, defender.archers);
    //         }

    //         if (attacker.archers > 0) {
    //             defender = archerDamage(defender, attacker.archers);
    //         }

    //         if (defender.soldiers > 0) {
    //             attacker = soldierDamage(attacker, defender.soldiers);
    //         }

    //         if (attacker.soldiers > 0) {
    //             defender = soldierDamage(defender, attacker.soldiers);
    //         }

    //         attackerHealth = calculateArmyHealth(attacker);
    //         defenderHealth = calculateArmyHealth(defender);

    //         log = abi.encodePacked(
    //             string(log),
    //             ',Turn: ',
    //             Strings.stringify(i + 1),
    //             ',Attacker Health: ',
    //             Strings.stringify(attackerHealth),
    //             ',Defender Health: ',
    //             Strings.stringify(defenderHealth)
    //         );
    //         winner = attackerHealth > defenderHealth;
    //         if (
    //             attackerHealth == 0 ||
    //             defenderHealth == 0 ||
    //             Army.isDefeated(attacker) ||
    //             Army.isDefeated(defender)
    //         ) {
    //             return (winner, log);
    //         }
    //     }
    //     return (winner, log);

    //     // If attackers have brought defenses they take 80% of damage until they are destroyed
    //     // Defenders defense structures will take 80% damage from attackers siege weapons
    //     // the Remaining damage will then be taken by Siege weapons up to a maximum of 50% of
    //     // the units health. THis process will work through all units until the uint has completed it's
    //     // attachk. This will continue until we have a winner.
    // }

    // function siegeWeaponDamage(Army.Info memory army, uint256 siegeWeapons)
    //     private
    //     returns (Army.Info memory)
    // {
    //     uint256 damage = siegeWeapons * SIEGE_WEAPON_DAMAGE; //300
    //     if (army.defenceStructures > 0) {
    //         //800
    //         army.defenceStructures = army.defenceStructures *
    //             DEFENCE_STRUCTURE_HEALTH >
    //             damage // 800 > 300 : true
    //             ? army.defenceStructures.sub(
    //                 damage.div(DEFENCE_STRUCTURE_HEALTH) // 300 / 200 = 1.5
    //             )
    //             : 0;
    //     } else if (army.siegeWeapons > 0) {
    //         army.siegeWeapons = army.siegeWeapons * SIEGE_WEAPON_HEALTH > damage
    //             ? army.siegeWeapons.sub(damage.div(SIEGE_WEAPON_HEALTH))
    //             : 0;
    //     } else if (army.archers > 0) {
    //         army.archers = army.archers * ARCHER_HEALTH > damage
    //             ? army.archers.sub(damage.div(ARCHER_HEALTH))
    //             : 0;
    //     } else if (army.soldiers > 0) {
    //         army.soldiers = army.soldiers * SOLDIER_HEALTH > damage
    //             ? army.soldiers.sub(damage.div(SOLDIER_HEALTH))
    //             : 0;
    //     } else if (army.cavalry > 0) {
    //         army.cavalry = army.cavalry * CAVALRY_HEALTH > damage
    //             ? army.cavalry.sub(damage.div(CAVALRY_HEALTH))
    //             : 0;
    //     }
    //     return army;
    // }

    // function cavalryDamage(Army.Info memory army, uint256 cavalry)
    //     private
    //     returns (Army.Info memory)
    // {
    //     uint256 damage = cavalry * CAVALRY_DAMAGE;
    //     if (army.soldiers > 0) {
    //         army.soldiers = army.soldiers * SOLDIER_HEALTH > damage
    //             ? army.soldiers.sub(damage.div(SOLDIER_HEALTH))
    //             : 0;
    //     } else if (army.cavalry > 0) {
    //         army.cavalry = army.cavalry * CAVALRY_HEALTH > damage
    //             ? army.cavalry.sub(damage.div(CAVALRY_HEALTH))
    //             : 0;
    //     } else if (army.defenceStructures > 0) {
    //         army.defenceStructures = army.defenceStructures *
    //             DEFENCE_STRUCTURE_HEALTH >
    //             damage
    //             ? army.defenceStructures.sub(
    //                 damage.div(DEFENCE_STRUCTURE_HEALTH)
    //             )
    //             : 0;
    //     } else if (army.siegeWeapons > 0) {
    //         army.siegeWeapons = army.siegeWeapons * SIEGE_WEAPON_HEALTH > damage
    //             ? army.siegeWeapons.sub(damage.div(SIEGE_WEAPON_HEALTH))
    //             : 0;
    //     } else if (army.archers > 0) {
    //         army.archers = army.archers * ARCHER_HEALTH > damage
    //             ? army.archers.sub(damage.div(ARCHER_HEALTH))
    //             : 0;
    //     }
    //     return army;
    // }

    // function archerDamage(Army.Info memory army, uint256 archers)
    //     private
    //     returns (Army.Info memory)
    // {
    //     uint256 damage = archers * ARCHER_DAMAGE;
    //     if (army.defenceStructures > 0) {
    //         army.defenceStructures = army.defenceStructures *
    //             DEFENCE_STRUCTURE_HEALTH >
    //             damage
    //             ? army.defenceStructures.sub(
    //                 damage.div(DEFENCE_STRUCTURE_HEALTH)
    //             )
    //             : 0;
    //     } else if (army.cavalry > 0) {
    //         army.cavalry = army.cavalry * CAVALRY_HEALTH > damage
    //             ? army.cavalry.sub(damage.div(CAVALRY_HEALTH))
    //             : 0;
    //     } else if (army.archers > 0) {
    //         army.archers = army.archers * ARCHER_HEALTH > damage
    //             ? army.archers.sub(damage.div(ARCHER_HEALTH))
    //             : 0;
    //     } else if (army.soldiers > 0) {
    //         army.soldiers = army.soldiers * SOLDIER_HEALTH > damage
    //             ? army.soldiers.sub(damage.div(SOLDIER_HEALTH))
    //             : 0;
    //     } else if (army.siegeWeapons > 0) {
    //         army.siegeWeapons = army.siegeWeapons * SIEGE_WEAPON_HEALTH > damage
    //             ? army.siegeWeapons.sub(damage.div(SIEGE_WEAPON_HEALTH))
    //             : 0;
    //     }
    //     return army;
    // }

    // function soldierDamage(Army.Info memory army, uint256 soldiers)
    //     private
    //     returns (Army.Info memory)
    // {
    //     uint256 damage = soldiers * SOLDIER_DAMAGE;
    //     if (army.soldiers > 0) {
    //         army.soldiers = army.soldiers * SOLDIER_HEALTH > damage
    //             ? army.soldiers.sub(damage.div(SOLDIER_HEALTH))
    //             : 0;
    //     } else if (army.archers > 0) {
    //         army.archers = army.archers * ARCHER_HEALTH > damage
    //             ? army.archers.sub(damage.div(ARCHER_HEALTH))
    //             : 0;
    //     } else if (army.defenceStructures > 0) {
    //         army.defenceStructures = army.defenceStructures *
    //             DEFENCE_STRUCTURE_HEALTH >
    //             damage
    //             ? army.defenceStructures.sub(
    //                 damage.div(DEFENCE_STRUCTURE_HEALTH)
    //             )
    //             : 0;
    //     } else if (army.siegeWeapons > 0) {
    //         army.siegeWeapons = army.siegeWeapons * SIEGE_WEAPON_HEALTH > damage
    //             ? army.siegeWeapons.sub(damage.div(SIEGE_WEAPON_HEALTH))
    //             : 0;
    //     }
    //     return army;
    // }

    // function calculateArmyHealth(Army.Info memory army)
    //     private
    //     returns (uint256 health)
    // {
    //     return
    //         army.siegeWeapons *
    //         SIEGE_WEAPON_HEALTH +
    //         army.defenceStructures *
    //         DEFENCE_STRUCTURE_HEALTH +
    //         army.soldiers *
    //         SOLDIER_HEALTH +
    //         army.archers *
    //         ARCHER_HEALTH +
    //         army.cavalry *
    //         CAVALRY_HEALTH;
    // }
}
