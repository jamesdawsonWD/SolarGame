import { takeSnapshot, revertSnapshot } from '../_utils/evm';
import { attack } from '../_helpers/gameOperations';
import { WEAK_FLEET, AVERAGE_FLEET } from '../lib/testValues';
import { sendSats, treasuryAddress } from '../_helpers/treasury';
import { satApproveForAll } from '../_helpers/sat';

import truffleAssert from 'truffle-assertions';
export default function() {
    contract('GameOperations#Attack', async accounts => {
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

            const WeakFleetIds = Object.keys(WEAK_FLEET);
            const WeakFleetAmounts = Object.values(WEAK_FLEET);
            await sendSats(UserA, WeakFleetIds, WeakFleetAmounts, UserA);
            await satApproveForAll(treasury, true, UserA);

            const AverageFleetIds = Object.keys(AVERAGE_FLEET);
            const AverageFleetAmounts = Object.values(AVERAGE_FLEET);
            await sendSats(UserB, AverageFleetIds, AverageFleetAmounts, UserB);
            await satApproveForAll(treasury, true, UserB);
        });

        //
        // Deposit
        //

        it('should attack the defender', async () => {
            await attack(UserB, 20, UserA);
        });
    });
}
