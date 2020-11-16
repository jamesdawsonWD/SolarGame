import { takeSnapshot, revertSnapshot } from '../_utils/evm';
import { move } from '../_helpers/traverse';
import { getMasterFleetPosition } from '../_helpers/gameStorage';
import truffleAssert from 'truffle-assertions';
export default function() {
    contract('GameOperations#Move', async accounts => {
        // Accounts
        const [owner, UserA, UserB, UserC, UserD] = accounts;

        const pos1 = [2, 1, 7, 42];
        const pos2 = [3, 4, 2, 1000];
        const outOfBounds = [7, 77, 66, 1333000];
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

        it('should move the user to a new star position', async () => {
            await move(pos1, UserA);
            const actualPos = await getMasterFleetPosition(UserA);
            assert.equal(pos1.toString(), actualPos.toString());
        });

        it('should fail if out of bounds', async () => {
            await truffleAssert.fails(
                userMove(outOfBounds, UserA),
                truffleAssert.ErrorType.revert,
                'Position must be within set limits of the known universe'
            );
        });

        it('should fail if attempting to move to same position', async () => {
            await userMove(pos1, UserA);
            await truffleAssert.fails(
                userMove(pos1, UserA),
                truffleAssert.ErrorType.revert,
                'You cannot move to your current location'
            );
        });
    });
}
