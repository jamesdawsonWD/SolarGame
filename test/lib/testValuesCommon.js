/* Useful aliases */
const BN = require('bignumber.js');

const toBN = web3.utils.toBN;

const BYTES_32 = `0x6c00000000000000000000000000000000000000000000000000000000000000`;

const ADDRESS_ZERO = '0x0000000000000000000000000000000000000000';
const MAX_UINT256 =
    '0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF';
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
    STRONG_FLEET
};
