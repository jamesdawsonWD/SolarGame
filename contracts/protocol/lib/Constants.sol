// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

library Constants {
    // Yield Ranges
    uint32 constant LOW_YIELD_LOW = 1;
    uint32 constant LOW_YIELD_HIGH = 75;

    uint32 constant MEDIUM_YIELD_LOW = 76;
    uint32 constant MEDIUM_YIELD_HIGH = 150;

    uint32 constant HIGH_YIELD_LOW = 151;
    uint32 constant HIGH_YIELD_HIGH = 400;

    uint32 constant INSANE_YIELD_LOW = 401;
    uint32 constant INSANE_YIELD_HIGH = 1000;

    // Total System Types
    uint256 constant TOTAL_SYSTEM_TYPES = 7;

    // Rolling
    uint32 constant MAX_ROLL = 10000;
    uint32 constant ONE_PERCENT_MAX_ROLL = MAX_ROLL / 100;
    uint32 constant POINT_ONE_PERCENT_OF_MAX_ROLL = MAX_ROLL / 1000;

    // Galaxy Boundaries
    uint256 constant MAX_QUADRANT = 4;
    uint256 constant MAX_DISTRACT = 8;
    uint256 constant MAX_SECTOR = 21;
    uint256 constant MAX_STAR = 10000;

    // Starting Position for all new addresses
    uint8 constant START_POSITION_QUADRANT = 1;
    uint8 constant START_POSITION_DISTRACT = 1;
    uint8 constant START_POSITION_SECTOR = 7;
    uint32 constant START_POSITION_STAR = 42;

    // Total Ships & Technology
    uint16 constant TOTAL_SAT_ITEMS = 46;

    // Bonus Variables
    uint256 constant DEFENSE_BONUS = 100000;
    uint256 constant TURNS = 10;

    // Goverance
    uint256 constant TOTAL_SUPPLY = 17000000;
    uint256 constant QORUM_VOTES = TOTAL_SUPPLY / 25;
    uint256 constant PROPOSAL_THRESHOLD = TOTAL_SUPPLY / 100;
    uint256 constant VOTING_PERIOD = 17280;
    uint256 constant VOTING_DELAY = 1;
    uint256 constant PROPOSAL_MAX_OPERATIONS = 10;

    struct Gas {
        uint16 QUADRANT;
        uint8 DISTRACT;
        uint8 SECTOR;
        uint8 STAR;
    }
    struct Battle {
        uint256 TURNS;
        uint256 DEFENDERS_BONUS;
    }

    struct StartPosition {
        uint8 QUADRANT;
        uint8 DISTRACT;
        uint8 SECTOR;
        uint32 STAR;
    }
    struct Boundaries {
        uint256 MAX_QUADRANT;
        uint256 MAX_DISTRACT;
        uint256 MAX_SECTOR;
        uint256 MAX_STAR;
    }

    struct State {
        Boundaries boundaries;
        mapping(uint256 => uint8) satOffences;
        mapping(uint256 => uint8) satDefenses;
        StartPosition startPosition;
        Battle battleInfo;
        Gas gas;
    }
}
