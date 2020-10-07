const truffleAssert = require('truffle-assertions');
const vals = require('./lib/testValuesCommon.js');
const protocol = require('./lib/protocol.js');
const BN = require('bignumber.js');
contract('NetworkAccess', accounts => {
    const [Owner, UserA, UserB, UserC] = accounts;
    let EternalStorage;
    let Treasury;
    before(
        async () =>
            ({ EternalStorage, Treasury } = await protocol.deploy(accounts))
    );

    describe('#access()', () => {
        it('Treasury should have access to FHR', async () => {
            const access = await EternalStorage.getBool(
                web3.utils.soliditySha3('fhr.access', Treasury.address)
            );
            assert.equal(access, true);
        });
    });
});
