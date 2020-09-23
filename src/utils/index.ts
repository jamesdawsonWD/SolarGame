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
