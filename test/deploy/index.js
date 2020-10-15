import { takeSnapshot, revertSnapshot } from '../_utils/evm';
import { getBool } from '../_helpers/eternalStorage';
import { treasuryAddress } from '../_helpers/treasury';
import truffleAssert from 'truffle-assertions';
import { getTreasuryAddress, getSolarAccess } from '../_helpers/gameStorage';
export default function() {
    contract('Deploy', async accounts => {
        // Accounts
        const [owner, UserA, UserB, UserC, UserD] = accounts;

        // State snapshotting
        let snapshotId;
        beforeEach(async () => {
            snapshotId = await takeSnapshot(web3);
        });
        afterEach(async () => {
            await revertSnapshot(web3, snapshotId);
        });

        it('should get the bool for treasury solar access', async () => {
            const treasury = await treasuryAddress();
            const solarAccess = await getSolarAccess(treasury, UserA);
            assert.equal(solarAccess, true);
        });
    });
}
