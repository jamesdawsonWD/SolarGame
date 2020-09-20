// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Require} from "./Require.sol";
import {Random} from "./Random.sol";

/**
 * @title Exchange
 * @author Big Beluga
 *
 * Library for transferring tokens and interacting with ExchangeWrappers by using the Wei struct
 */
library Samurai {
    struct Info {
        uint256 id;
        uint8 strength;
        uint8 wisdom;
        uint8 agility;
        uint8 dexterity;
        uint8 intelligence;
        uint8 charisma;
        uint8 honour;
    }
    // ============ Constants ============

    bytes32 constant FILE = "Samurai";

    // ============ Library Functions ============

    function create(uint256 seed, uint256 _id)
        internal
        returns (Info memory samurai, uint256 newSeed)
    {
        uint256 rand1 = Random.rand(seed);
        uint256 rand2 = Random.rand(rand1);
        uint256 rand3 = Random.rand(rand2);
        uint256 rand4 = Random.rand(rand3);
        uint256 rand5 = Random.rand(rand4);
        uint256 rand6 = Random.rand(rand5);
        uint256 rand7 = Random.rand(rand6);

        return (
            Info({
                id: _id,
                strength: uint8(rand1),
                wisdom: uint8(rand2),
                agility: uint8(rand3),
                dexterity: uint8(rand4),
                intelligence: uint8(rand5),
                charisma: uint8(rand6),
                honour: uint8(rand7)
            }),
            rand7
        );
    }
}
