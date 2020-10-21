import * as BN from 'bignumber.js';
export const addressZero = '0x' + '0'.repeat(40);
export const SECONDS_IN_DAY = 86400;
export const advanceTime = time => {
    return new Promise((resolve, reject) => {
        window.web3.currentProvider.send(
            {
                jsonrpc: '2.0',
                method: 'evm_increaseTime',
                params: [time],
                id: new Date().getTime()
            },
            (err, result) => {
                if (err) {
                    return reject(err);
                }
                return resolve(result);
            }
        );
    });
};

export const SYSTEM_TYPES = {
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

export const SYSTEM_TYPES_IDS = {
    0: 'Undiscovered',
    1: 'AncientFleetAggressive',
    2: 'SuperComputerEvent',
    3: 'AdvancedAlienFleetAggressiv',
    4: 'AiFleetAggressiv',
    5: 'AlienFleetAggressiv',
    6: 'PiratesEven',
    7: 'SolarWind',
    8: 'Asteroid',
    9: 'Empty',
    10: 'GovermentOwned',
    11: 'LowYieldSystem',
    12: 'RandomEvent',
    13: 'MediumYieldSystem',
    14: 'ShipWreck',
    15: 'HighYieldSystem',
    16: 'AncientMiningSystem',
    17: 'AncientWeaponSystem',
    18: 'AncientShipWreck',
    19: 'InsaneYieldSystem',
    20: 'AncientRacePassive'
};
