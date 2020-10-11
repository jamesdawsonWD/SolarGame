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
import { withdrawAll } from './scenario-withdrawAll-fleet';
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
            await sendSats(UserA, Object.keys(WEAK_FLEET), Object.values(WEAK_FLEET), UserA);
            await approveForAll(treasury, true, UserA);
        });

        //
        // Deposit
        //

        it('should lock in the correct fleet size', async () => {
            await lockin(accounts);
        });
        it('should withdraw the entire fleet from a locked in fleet', async () => {
            const ids = Object.keys(WEAK_FLEET);
            const amounts = Object.values(WEAK_FLEET);
            await withdraw(accounts, ids, amounts);
        });
        it('should withdraw the correct fleet size from a locked in fleet', async () => {
            const ids = Object.keys(WEAK_FLEET).slice(2);
            const amounts = Object.values(WEAK_FLEET).slice(2);
            await withdraw(accounts, ids, amounts);
        });
    });
}
