export const advanceTime = time => {
    return new Promise((resolve, reject) => {
        web3.currentProvider.send(
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

export const advanceBlock = () => {
    return new Promise((resolve, reject) => {
        web3.currentProvider.send(
            {
                jsonrpc: '2.0',
                method: 'evm_mine',
                id: new Date().getTime()
            },
            (err, result) => {
                if (err) {
                    return reject(err);
                }
                const newBlockHash = web3.eth.getBlock('latest').hash;

                return resolve(newBlockHash);
            }
        );
    });
};

// Take a snapshot of the EVM state
export function takeSnapshot(web3) {
    return new Promise((resolve, reject) => {
        web3.currentProvider.send(
            {
                jsonrpc: '2.0',
                method: 'evm_snapshot',
                id: new Date().getTime()
            },
            function(err, response) {
                if (err) {
                    reject(err);
                } else if (response && response.result) {
                    resolve(response.result);
                } else {
                    reject('Unknown error');
                }
            }
        );
    });
}

// Restore a snapshot of EVM state
export function revertSnapshot(web3, snapshotId) {
    return new Promise((resolve, reject) => {
        web3.currentProvider.send(
            {
                jsonrpc: '2.0',
                method: 'evm_revert',
                params: [snapshotId],
                id: new Date().getTime()
            },
            function(err, response) {
                if (err) {
                    reject(err);
                } else {
                    resolve();
                }
            }
        );
    });
}
export const advanceTimeAndBlock = async time => {
    await advanceTime(time);
    await advanceBlock();
    return Promise.resolve(web3.eth.getBlock('latest'));
};
