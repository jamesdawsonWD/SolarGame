import { takeSnapshot, revertSnapshot } from '../_utils/evm';
import { SYSTEM_TYPES } from '../lib/testValues';
import { deployPlanet, testFhrDiscovery } from '../_helpers/gameOperations';
import { tokenOfOwnerByIndex } from '../_helpers/fhr';
export default function() {
    contract('Deploy', async accounts => {
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

        it('should deploy a planet', async () => {
            await testFhrDiscovery(SYSTEM_TYPES.LowYieldSystem, UserA);
            const planetToken = await tokenOfOwnerByIndex(UserA, 0, UserA);
            await deployPlanet(planetToken, UserA);
        });
    });
}
