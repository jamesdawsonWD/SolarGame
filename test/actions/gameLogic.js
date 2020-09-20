const truffleAssert = require('truffle-assertions');
const vals = require('../lib/testValuesCommon.js');
const protocol = require('../lib/protocol.js');
const BN = require('bignumber.js');
contract('GameOperations', (accounts) => {
    const [Owner, UserA, UserB, UserC] = accounts;
    const ZERO = vals.ZERO;
    let Master;
    let Tsuno;
    before(async () => {
        [Master, Tsuno] = await protocol.deploy(accounts);
        await Master.giveArmyA({
            from: UserA
        });
        await Master.giveArmyB({
            from: UserB
        });
    });

    describe('#attack()', () => {
        it('should fail if amount is less than or equal to 0', async () => {
            const UserA_balanceBefore = await Master.getBalance({
                from: UserA,
            });
            const UserB_balanceBefore = await Master.getBalance({
                from: UserB,
            });

            assert.ok(new BN(ZERO).isEqualTo(UserB_balanceBefore));

            const UserA_DepositP = Master.deposit(100000, 39, {
                from: UserA
            });
            const UserB_DepositP = Master.deposit(100000, 39, {
                from: UserB
            });

            const UserA_balanceAfterD = await Master.getBalance({
                from: UserA,
            });
            const UserB_balanceAfterD = await Master.getBalance({
                from: UserB,
            });

            console.log(UserA_balanceAfterD.toString());
            console.log(UserB_balanceAfterD.toString());

            await Promise.all([UserA_DepositP, UserB_DepositP]);

            await Master.attack(UserB, {
                from: UserA
            });

            const UserA_balanceAfter = await Master.getBalance({
                from: UserA,
            });
            const UserB_balanceAfter = await Master.getBalance({
                from: UserB,
            });

            console.log(UserA_balanceAfter.toString());
            console.log(UserB_balanceAfter.toString());
            // assert.equal(new BN(ZERO), UserA_balanceAfter.toString());
            // assert.equal(new BN(ZERO), UserA_balanceAfter.toString());
            // assert.equal(new BN(ZERO), UserB_balanceAfter.toString());
        });
    });
});
