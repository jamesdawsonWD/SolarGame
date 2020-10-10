import { takeSnapshot, revertSnapshot } from '../_utils/evm';
import {
    withdrawMasterFleet,
    lockinMasterFleet,
    gameOperationsAddress
} from '../_helpers/gameOperations';
import { WEAK_FLEET } from '../lib/testValues';
import { sendSats, treasuryAddress } from '../_helpers/treasury';
import { approveForAll } from '../_helpers/sat';
import { lockin } from './scenario-lockin-fleet';
import truffleAssert from 'truffle-assertions';
export default function() {
    contract('GameOperations#LockInMasterFleet', async accounts => {
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

        // Setup
        before(async () => {
            const treasury = await treasuryAddress();
            const gameOperations = await gameOperationsAddress();
            await sendSats(UserA, Object.keys(WEAK_FLEET), Object.values(WEAK_FLEET), UserA);
            await approveForAll(treasury, true, UserA);
        });

        //
        // Deposit
        //

        it('should lock in the correct fleet size', async () => {
            await lockin(accounts);
        });
    });
}
