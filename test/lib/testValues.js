/* Useful aliases */
const BN = require('bignumber.js');

const toBN = web3.utils.toBN;

const BYTES_32 = `0x6c00000000000000000000000000000000000000000000000000000000000000`;

const ADDRESS_ZERO = '0x0000000000000000000000000000000000000000';
const TEST_ADDRESS = '0x7Bb66D304c1F50AB17Bd56031D21de749404081e';
const MAX_UINT256 = '0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF';
const MAX_UINT256_BN = toBN(MAX_UINT256);

const YIELDS = {
    LowYieldSystem: {
        low: 1,
        high: 75
    },
    InsaneYieldSystem: {
        low: 401,
        high: 1000
    },
    MediumYieldSystem: {
        low: 76,
        high: 150
    },
    HighYieldSystem: {
        low: 151,
        high: 400
    }
};

const ZERO = new BN(0);
const SECONDS_IN_DAY = 86400;
const SYSTEM_TYPES = {
    Undiscovered: 0,
    AncientFleetAggressive: 1,
    SuperComputerEvent: 2,
    AdvancedAlienFleetAggressive: 3,
    AiFleetAggressive: 4,
    AlienFleetAggressive: 5,
    PiratesEvent: 6,
    SolarWinds: 7,
    Asteroids: 8,
    Empty: 9,
    GovermentOwned: 10,
    LowYieldSystem: 11,
    RandomEvent: 12,
    MediumYieldSystem: 13,
    ShipWreck: 14,
    HighYieldSystem: 15,
    AncientMiningSystem: 16,
    AncientWeaponSystem: 17,
    AncientShipWreck: 18,
    InsaneYieldSystem: 19,
    AncientRacePassive: 20
};
const WEAK_FLEET = {
    1: 5,
    2: 1,
    3: 1,
    4: 1
};

const AVERAGE_FLEET = {
    8: 1,
    9: 3,
    10: 3,
    13: 5
};

const STRONG_FLEET = {
    21: 10,
    22: 10,
    23: 10,
    43: 10
};

const ALL_SHIPS = {
    0: 5,
    1: 5,
    2: 5,
    3: 5,
    4: 5,
    5: 5,
    6: 5,
    7: 5,
    8: 5,
    9: 5,
    10: 5,
    11: 5,
    12: 5,
    13: 5,
    14: 5,
    15: 5,
    16: 5,
    17: 5,
    18: 5,
    19: 5,
    20: 5,
    21: 5,
    22: 5,
    23: 5,
    24: 5,
    25: 5,
    26: 5,
    27: 5,
    28: 5,
    29: 5,
    30: 5,
    31: 5,
    32: 5,
    33: 5,
    34: 5,
    35: 5,
    36: 5,
    37: 5,
    38: 5,
    39: 5,
    40: 5,
    41: 5,
    42: 5,
    43: 5
};

const SHIP_INFO = {
    0: {
        offense: 9,
        defense: 9
    },
    1: {
        offense: 10,
        defense: 10
    },
    2: {
        offense: 15,
        defense: 15
    },
    3: {
        offense: 2,
        defense: 2
    },
    4: {
        offense: 1,
        defense: 1
    },
    5: {
        offense: 1,
        defense: 1
    },
    6: {
        offense: 1,
        defense: 1
    },
    7: {
        offense: 2,
        defense: 2
    },
    8: {
        offense: 1,
        defense: 1
    },
    9: {
        offense: 2,
        defense: 2
    },
    10: {
        offense: 3,
        defense: 3
    },
    11: {
        offense: 12,
        defense: 12
    },
    12: {
        offense: 13,
        defense: 13
    },
    13: {
        offense: 10,
        defense: 10
    },
    14: {
        offense: 3,
        defense: 3
    },
    15: {
        offense: 1,
        defense: 1
    },
    16: {
        offense: 1,
        defense: 1
    },
    17: {
        offense: 2,
        defense: 2
    },
    18: {
        offense: 3,
        defense: 3
    },
    19: {
        offense: 2,
        defense: 2
    },
    20: {
        offense: 3,
        defense: 3
    },
    21: {
        offense: 4,
        defense: 4
    },
    22: {
        offense: 15,
        defense: 15
    },
    23: {
        offense: 15,
        defense: 15
    },
    24: {
        offense: 20,
        defense: 20
    },
    25: {
        offense: 5,
        defense: 5
    },
    26: {
        offense: 2,
        defense: 2
    },
    27: {
        offense: 2,
        defense: 2
    },
    28: {
        offense: 3,
        defense: 3
    },
    29: {
        offense: 4,
        defense: 4
    },
    30: {
        offense: 5,
        defense: 5
    },
    31: {
        offense: 6,
        defense: 6
    },
    32: {
        offense: 7,
        defense: 7
    },
    33: {
        offense: 20,
        defense: 20
    },
    34: {
        offense: 21,
        defense: 21
    },
    35: {
        offense: 30,
        defense: 30
    },
    36: {
        offense: 10,
        defense: 10
    },
    37: {
        offense: 5,
        defense: 5
    },
    38: {
        offense: 5,
        defense: 5
    },
    39: {
        offense: 6,
        defense: 6
    },
    40: {
        offense: 7,
        defense: 7
    },
    41: {
        offense: 8,
        defense: 8
    },
    42: {
        offense: 9,
        defense: 9
    },
    43: {
        offense: 10,
        defense: 10
    }
};

module.exports = {
    ADDRESS_ZERO,
    TEST_ADDRESS,
    MAX_UINT256,
    MAX_UINT256_BN,
    BYTES_32,
    ZERO,
    SECONDS_IN_DAY,
    WEAK_FLEET,
    AVERAGE_FLEET,
    STRONG_FLEET,
    SHIP_INFO,
    ALL_SHIPS,
    SYSTEM_TYPES,
    YIELDS
};
