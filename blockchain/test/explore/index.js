import { takeSnapshot, revertSnapshot } from '../_utils/evm';
import { mintFhr } from '../_helpers/planetToken';
import { SYSTEM_TYPES } from '../lib/testValues';

import { testFhrDiscovery } from '../_helpers/gameOperations';
import truffleAssert from 'truffle-assertions';
import { fhrDiscovery } from './scenario-fhr-discovery';
export default function() {
    contract('Explore', async accounts => {
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

        it('should discover a low yield planet', async () => {
            await fhrDiscovery(Owner, SYSTEM_TYPES.LowYieldSystem);
        });
        it('should discover a medium yield planet', async () => {
            await fhrDiscovery(Owner, SYSTEM_TYPES.MediumYieldSystem);
        });
        it('should discover a high yield planet', async () => {
            await fhrDiscovery(Owner, SYSTEM_TYPES.HighYieldSystem);
        });
        it('should discover a insane yield planet', async () => {
            await fhrDiscovery(Owner, SYSTEM_TYPES.InsaneYieldSystem);
        });
    });
}
