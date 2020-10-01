const truffleAssert = require('truffle-assertions');
const vals = require('../lib/testValuesCommon.js');
const protocol = require('../lib/protocol.js');
const BN = require('bignumber.js');
contract('GameOperations', accounts => {
    const [Owner, UserA, UserB, UserC] = accounts;
    const ZERO = vals.ZERO;
    let Master;
    let Tsuno;
    let Sat;
    let Solar;
    before(async () => {
        [Master, Tsuno, Sat, Solar] = await protocol.deploy(accounts);
    });

    describe('#move', () => {
        it('should fail if star position is out of bounds', async () => {
            const from = [2, 1, 1, 1];
            const to = [7, 1, 1, 7256];

            const moveP = Master.move(from, to, { from: UserA });
            await truffleAssert.fails(
                moveP,
                truffleAssert.ErrorType.revert,
                'Position must be within set limits of the known universe'
            );
        });

        it('should fail if star position are equal', async () => {
            const pos = [1, 1, 7, 42];

            const moveP = Master.move(pos, pos, { from: UserA });
            await truffleAssert.fails(
                moveP,
                truffleAssert.ErrorType.revert,
                'You cannot move to your current location'
            );
        });

        it('should move', async () => {
            const from = [2, 1, 1, 1];
            const to = [1, 1, 1, 7256];

            await Master.move(from, to, { from: UserA });
        });
    });
});
