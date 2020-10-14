import { takeSnapshot, revertSnapshot } from '../_utils/evm';
import {
    getSolarAddress,
    getSatAddress,
    getFhrAddress,
    getSatInfo,
    getStartPosition,
    getStarSystemYield,
    setStarSystemYield,
    getStakedBalance,
    setStakedBalance,
    getDateStakeLocked,
    setDateStakeLocked
} from '../_helpers/gameStorage';
import { satAddress } from '../_helpers/sat';
import { solarAddress } from '../_helpers/solar';
import { fhrAddress } from '../_helpers/fhr';
import { SHIP_INFO } from '../lib/testValues';
import truffleAssert from 'truffle-assertions';
export default function() {
    contract('Game Operations Unit Testing', async accounts => {
        // Accounts
        const [Owner, UserA, UserB, UserC, UserD] = accounts;

        // State snapshotting
        let snapshotId;
        beforeEach(async () => {
            snapshotId = await takeSnapshot(web3);
        });
        afterEach(async () => {
            await revertSnapshot(web3, snapshotId);
        });

        // Setup
        before(async () => {});

        //
        // Deposit
        //

        it('should get the correct sat address', async () => {
            const address = await getSatAddress(Owner);
            const acctualAddress = await satAddress();
            assert.equal(address, acctualAddress);
        });

        it('should get the correct solar address', async () => {
            const address = await getSolarAddress(Owner);
            const acctualAddress = await solarAddress();
            assert.equal(address, acctualAddress);
        });

        it('should get the correct fhr address', async () => {
            const address = await getFhrAddress(Owner);
            const acctualAddress = await fhrAddress();
            assert.equal(address, acctualAddress);
        });

        it('should get the correct sat info for each item', async () => {
            const _ids = Object.keys(SHIP_INFO);
            for (const id of _ids) {
                const info = await getSatInfo(id, Owner);
                assert.equal(info.offense.toString(), SHIP_INFO[id].offense.toString(), id);
                assert.equal(info.defense.toString(), SHIP_INFO[id].defense.toString(), id);
            }
        });

        it('should get the correct start position', async () => {
            const info = await getStartPosition(Owner);
        });

        it('should set & get the correct star system yield', async () => {
            await setStarSystemYield(1, 140, Owner);
            const systemYield = await getStarSystemYield(1, Owner);
            assert.equal(systemYield.toString(), '140');
        });
        it('should set & get the correct staked balance', async () => {
            await setStakedBalance(UserA, 1, 1000000, Owner);
            const balance = await getStakedBalance(UserA, 1, Owner);
            assert.equal(balance.toString(), '1000000');
        });
        it('should set & get the date stake locked in', async () => {
            await setDateStakeLocked(UserA, 1, 1000000, Owner);
            const balance = await getDateStakeLocked(UserA, 1, Owner);
            assert.equal(balance.toString(), '1000000');
        });
    });
}
