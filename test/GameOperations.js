const truffleAssert = require('truffle-assertions');
const {
    WEAK_FLEET,
    AVERAGE_FLEET,
    STRONG_FLEET
} = require('./lib/testValuesCommon.js');
const protocol = require('./lib/protocol.js');
const BN = require('bignumber.js');
contract('GameOperation', accounts => {
    const [Owner, UserA, UserB, UserC] = accounts;

    let GameOperations;
    let GameStorage;
    before(
        async () =>
            ({ GameOperations, GameStorage } = await protocol.deploy(accounts))
    );

    describe('#move()', () => {
        it('should move the user to a new star position', async () => {
            const pos = [2, 1, 7, 42];

            await GameOperations.move(pos, { from: UserA });

            // const TOTAL_SUPPLY = await EternalStorage.getUint(
            //     web3.utils.soliditySha3('constants.governance.total_supply')
            // );
            // assert.equal(TOTAL_SUPPLY, 17000000);
        });
    });

    describe('#lockInMasterFleet()', () => {
        it('should lock in the correct fleet', async () => {
            const ids = Object.keys(WEAK_FLEET);
            const amounts = Object.values(WEAK_FLEET);
            await GameOperations.lockInMasterFleet(ids, amounts, {
                from: UserA
            });

            for (let i = 0; i < ids.length; i++) {
                const amount = await GameStorage.getMasterLockedInShipInfo(
                    UserA,
                    ids[i],
                    { from: UserA }
                );
                assert.equal(amount, amounts[i]);
            }
        });
    });

    describe('#withdrawMasterFleet()', () => {
        it('should withdraw the previosuly locked in fleet', async () => {
            const ids = Object.keys(WEAK_FLEET);
            const amounts = Object.values(WEAK_FLEET);
            await GameOperations.withdrawMasterFleet(ids, amounts, {
                from: UserA
            });

            for (let i = 0; i < ids.length; i++) {
                const amount = await GameStorage.getMasterLockedInShipInfo(
                    UserA,
                    ids[i],
                    { from: UserA }
                );
                assert.equal(amount, 0);
            }
        });
    });
});
