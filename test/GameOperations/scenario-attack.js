// import { protocol } from '../core/protocol.js';
// import { takeSnapshot, revertSnapshot } from '../lib/helpers.js';
// export default function() {
//     contract('GameOperationJest', accounts => {
//         const [Owner, UserA, UserB, UserC] = accounts;

//         let GameOperations;
//         let GameStorage;
//         // State snapshotting
//         let snapshotId;
//         beforeEach(async () => {
//             snapshotId = await takeSnapshot(web3);
//         });
//         afterEach(async () => {
//             await revertSnapshot(web3, snapshotId);
//         });
//         it('should move the user to a new star position', async () => {
//             const pos = [2, 1, 7, 42];

//             await GameOperations.move(pos, { from: UserA });

//             // const TOTAL_SUPPLY = await EternalStorage.getUint(
//             //     web3.utils.soliditySha3('constants.governance.total_supply')
//             // );
//             // assert.equal(TOTAL_SUPPLY, 17000000);
//         });
//     });
// }
