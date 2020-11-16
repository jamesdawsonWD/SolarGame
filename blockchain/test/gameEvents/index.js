import { takeSnapshot, revertSnapshot } from '../_utils/evm';
import { generate, trigger } from '../_helpers/gameEvents';
import { getMasterFleetPosition } from '../_helpers/gameStorage';
import truffleAssert from 'truffle-assertions';
export default function() {
    contract('GameOperations#Move', async accounts => {
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
        before(async () => {});

        //
        // Deposit
        //

        it('should generate a uint between 0 and the totalNumber of gameEvents ', async () => {
            await generate(pos1, UserA);
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
