/* Useful aliases */
const BN = require('bignumber.js');

const toBN = web3.utils.toBN;

const BYTES_32 = `0x6c00000000000000000000000000000000000000000000000000000000000000`;

const ADDRESS_ZERO = '0x0000000000000000000000000000000000000000';
const MAX_UINT256 = '0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF';
const MAX_UINT256_BN = toBN(MAX_UINT256);
const ACTIONS = {
    DEPOSIT: 0,
    WITHDRAW: 1,
    INVEST: 2,
    CLOSE: 3,
    TRADE: 4,
    TRANSFER: 5
};
const ZERO = new BN(0);
const SECONDS_IN_DAY = 86400;

const WEAK_FLEET = {
    1: 5,
    2: 1,
    3: 1,
    4: 1
};

const AVERAGE_FLEET = {
    8: 1,
    9: 6,
    10: 7,
    13: 7
};

const STRONG_FLEET = {
    21: 10,
    22: 10,
    23: 10,
    45: 10
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
    MAX_UINT256,
    MAX_UINT256_BN,
    BYTES_32,
    ACTIONS,
    ZERO,
    SECONDS_IN_DAY,
    WEAK_FLEET,
    AVERAGE_FLEET,
    STRONG_FLEET,
    SHIP_INFO
};
