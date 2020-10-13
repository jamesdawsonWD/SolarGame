import { takeSnapshot, revertSnapshot } from '../_utils/evm';
import {
    withdrawMasterFleet,
    lockinMasterFleet,
    gameOperationsAddress
} from '../_helpers/gameOperations';
import { WEAK_FLEET, AVERAGE_FLEET, ALL_SHIPS } from '../lib/testValues';
import { sendSats, treasuryAddress } from '../_helpers/treasury';
import { approveForAll } from '../_helpers/sat';
import { lockin } from './scenario-lockin-fleet';
import { withdraw } from './scenario-withdraw-fleet';
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
            await sendSats(UserA, Object.keys(ALL_SHIPS), Object.values(ALL_SHIPS), UserA);
            await approveForAll(treasury, true, UserA);
        });

        //
        // Deposit
        //

        it('should lock in the correct fleet size', async () => {
            const ids = Object.keys(WEAK_FLEET);
            const amounts = Object.values(WEAK_FLEET);
            await lockin(UserA, ids, amounts);
        });
        it('should withdraw the entire fleet from a locked in fleet', async () => {
            const ids = Object.keys(WEAK_FLEET);
            const amounts = Object.values(WEAK_FLEET);
            await lockin(UserA, ids, amounts);
            await withdraw(UserA, ids, amounts);
        });
        it('should withdraw the correct fleet size from a locked in fleet', async () => {
            const ids = Object.keys(WEAK_FLEET);
            const amounts = Object.values(WEAK_FLEET);
            await lockin(UserA, ids, amounts);
            await withdraw(UserA, ids.slice(2), amounts.slice(2));
        });
        it('should work with locking in every ship possible', async () => {
            const ids = Object.keys(ALL_SHIPS);
            const amounts = Object.values(ALL_SHIPS);
            await lockin(UserA, ids, amounts);
            await withdraw(UserA, ids, amounts);
        });
        it('should work when locking in the ships back to back', async () => {
            await lockin(UserA, Object.keys(WEAK_FLEET), Object.values(WEAK_FLEET));
            await lockin(UserA, Object.keys(AVERAGE_FLEET), Object.values(AVERAGE_FLEET));
        });
    });
}
