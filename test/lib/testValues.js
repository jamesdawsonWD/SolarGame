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
        viewName: 'Federation Master Vessel',
        name: 'FEDERATION_MASTER_VESSEL',
        offense: 9,
        defense: 9
    },
    1: {
        viewName: 'Federation Cruiser',
        name: 'FEDERATION_CRUISER',
        offense: 10,
        defense: 10
    },
    2: {
        viewName: 'Federation Destroyer',
        name: 'FEDERATION_DESTROYER',
        offense: 15,
        defense: 15
    },
    3: {
        viewName: 'Federation Fighter Plane',
        name: 'FEDERATION_FIGHTER_PLANE',
        offense: 2,
        defense: 2
    },
    4: {
        viewName: 'Alien Master Vessel',
        name: 'ALIEN_MASTER_VESSEL',
        offense: 1,
        defense: 1
    },
    5: {
        viewName: 'Alien Cruiser',
        name: 'ALIEN_CRUISER',
        offense: 1,
        defense: 1
    },
    6: {
        viewName: 'Alien Destroyer',
        name: 'ALIEN_DESTROYER',
        offense: 1,
        defense: 1
    },
    7: {
        viewName: 'Alien Fighter Plane',
        name: 'ALIEN_FIGHTER_PLANE',
        offense: 2,
        defense: 2
    },
    8: {
        viewName: 'Federation Cruiser',
        name: 'ADVANCED_RACE_MASTER_VESSEL',
        offense: 1,
        defense: 1
    },
    9: {
        viewName: 'Federation Cruiser',
        name: 'ADVANCED_RACE_CRUISER',
        offense: 2,
        defense: 2
    },
    10: {
        viewName: 'Federation Cruiser',
        name: 'ADVANCED_RACE_DESTROYER',
        offense: 3,
        defense: 3
    },
    11: {
        viewName: 'Federation Cruiser',
        name: 'ADVANCED_RACE_FIGHTER_PLANE',
        offense: 12,
        defense: 12
    },
    12: {
        viewName: 'Federation Cruiser',
        name: 'ANCIENT_MASTER_VESSEL',
        offense: 13,
        defense: 13
    },
    13: {
        viewName: 'Federation Cruiser',
        name: 'ANCIENT_CRUISER',
        offense: 10,
        defense: 10
    },
    14: {
        viewName: 'Federation Cruiser',
        name: 'ANCIENT_DESTROYER',
        offense: 3,
        defense: 3
    },
    15: {
        viewName: 'Federation Cruiser',
        name: 'ANCIENT_FIGHTER_PLANE',
        offense: 1,
        defense: 1
    },
    16: {
        viewName: 'Federation Cruiser',
        name: 'PIRATE_SHIP',
        offense: 1,
        defense: 1
    },
    17: {
        viewName: 'Federation Cruiser',
        name: 'PIRATE_WEAPON',
        offense: 2,
        defense: 2
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
