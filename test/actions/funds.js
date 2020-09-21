const truffleAssert = require('truffle-assertions');
const vals = require('../lib/testValuesCommon.js');
const protocol = require('../lib/protocol.js');
const BN = require('bignumber.js');
const {
    advanceTime
} = require('../lib/helpers.js');
contract('FundOperations', accounts => {
    const [Owner, UserA, UserB, UserC] = accounts;
    const ZERO = vals.ZERO;
    const SECONDS_IN_A_DAY = vals.SECONDS_IN_DAY;
    let Master;
    let Tsuno;
    before(async () => ([Master, Tsuno] = await protocol.deploy(accounts)));

    describe('#deposit()', () => {
        it('should fail if amount is less than or equal to 0', async () => {
            const DepositP = Master.deposit(0, 39, {
                from: UserA
            });
            await truffleAssert.fails(
                DepositP,
                truffleAssert.ErrorType.revert,
                'FundOperations#Deposit: Amount must be greater than 0'
            );
        });

        it('should fail if time is less than or equal to 0', async () => {
            const DepositP = Master.deposit(1000, 0, {
                from: UserA
            });
            await truffleAssert.fails(
                DepositP,
                truffleAssert.ErrorType.revert,
                'FundOperations#Deposit: Time must be greater than 0'
            );
        });

        it('should add correct balance & reward to the correct account', async () => {
            await Master.deposit(10000, 31, {
                from: UserA
            });

            const bal = await Master.getBalance({
                from: UserA
            });
            console.log(bal);
            assert.equal(bal, 10000);
        });
    });

    describe('#withdraw()', () => {
        it('should fail if the stake period has not complete', async () => {
            const WithdrawP = Master.withdraw({
                from: UserA
            });

            await truffleAssert.fails(
                WithdrawP,
                truffleAssert.ErrorType.revert,
                'FundOperations#Withdraw: Stake period is not complete'
            );
        });
        it('should withdraw the correct amount and send the reward to the correct address', async () => {
            const reward = Master.getReward({
                from: UserA
            });

            await advanceTime(SECONDS_IN_A_DAY * 365);
            await Master.withdraw({
                from: UserA
            });
            const bal = await Master.getBalance({
                from: UserA
            });
            assert.equal(bal, 0);

            const UserTsuno = await Tsuno.balanceOf(UserA);
            const MasterTsuno = await Tsuno.balanceOf(Master.address);

            assert.ok(UserTsuno, reward);
            assert.equal(MasterTsuno.toString(), 0);
        });
    });
});
