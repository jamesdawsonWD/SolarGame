const truffleAssert = require('truffle-assertions');
const vals = require('./lib/testValuesCommon.js');
const protocol = require('./lib/protocol.js');
const BN = require('bignumber.js');
contract('GameStorage', accounts => {
    const [Owner, UserA, UserB, UserC] = accounts;
    let FHR;
    let Sat;
    let Solar;
    let EternalStorage;
    let GameStorage;
    let Treasury;
    before(
        async () =>
            ({
                GameStorage,
                EternalStorage,
                FHR,
                Sat,
                Solar,
                Treasury
            } = await protocol.deploy(accounts))
    );

    describe('#constants()', () => {
        it('should get solar contract address', async () => {
            const SolarAddress = await GameStorage.getSolarAddress();
            assert.equal(SolarAddress, Solar.address);
        });
        it('should get FHR contract address', async () => {
            const FHRAddress = await GameStorage.getFHRAddress();
            assert.equal(FHRAddress, FHR.address);
        });
        it('should get Sat contract address', async () => {
            const SatAddress = await GameStorage.getSatAddress();
            assert.equal(SatAddress, Sat.address);
        });
        it('should get Treasury contract address', async () => {
            const TreasuryAddress = await GameStorage.getTreasuryAddress();
            assert.equal(TreasuryAddress, Treasury.address);
        });
        it('should get Star Boundaries contract address', async () => {
            const Boundaries = await GameStorage.getBoundaries();
            assert.equal(Boundaries[0], 4);
            assert.equal(Boundaries[1], 21);
            assert.equal(Boundaries[2], 8);
            assert.equal(Boundaries[3], 10000);
        });
    });
    describe('#MasterFleet()', () => {
        it('it should set the correct MasterFleet Position', async () => {
            const pos = [1, 1, 2, 257];
            await GameStorage.setMasterFleetPosition(UserA, pos);
            const results = await Promise.all([
                EternalStorage.getUint8(
                    web3.utils.soliditySha3(
                        'master.fleet.position.quadrant',
                        UserA
                    )
                ),
                EternalStorage.getUint8(
                    web3.utils.soliditySha3(
                        'master.fleet.position.sector',
                        UserA
                    )
                ),
                EternalStorage.getUint8(
                    web3.utils.soliditySha3(
                        'master.fleet.position.district',
                        UserA
                    )
                ),
                EternalStorage.getUint(
                    web3.utils.soliditySha3('master.fleet.position.star', UserA)
                )
            ]);

            for (let i = 0; i < pos.length; i++) {
                assert.equal(results[i].toString(), pos[i].toString());
            }
        });
    });
});
