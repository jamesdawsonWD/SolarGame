import { ActionTree, ActionContext } from 'vuex';
import { RootState, FundOperations, Deposit } from '../types';
import BN from 'bignumber.js';
export const actions: ActionTree<FundOperations, RootState> = {
    async getBalance(context: ActionContext<FundOperations, RootState>) {
        const { Master, Address } = context.getters;
        const balance = await Master.methods
            .getBalance()
            .call({ from: Address });
        context.commit('SET_BALANCE', balance);
    },
    async getDateUnlocked(context: ActionContext<FundOperations, RootState>) {
        const { Master, Address } = context.getters;
        const unlocked = await Master.methods
            .getDateUnlocked()
            .call({ from: Address });
        console.log('unlocked', unlocked);
        context.commit('SET_DATE_UNLOCKED', unlocked);
    },
    withdraw(context: ActionContext<FundOperations, RootState>) {
        const { Master, Tsuno, Address, DateUnlocked } = context.getters;
        console.log(DateUnlocked);
        context
            .dispatch('getDateUnlocked')
            .then(() => {
                const date = new Date().getTime() / 1000;
                console.log(DateUnlocked, date);
                if (DateUnlocked <= date)
                    return Master.methods.withdraw().send({ from: Address });
                else throw new Error('Lock in period is not complete');
            })
            .then(() => {
                context.dispatch('getBalance');
                context.dispatch('getTsunoBalance');
            })
            .catch((err: Error) => context.dispatch('setError', err));
    },
    emergencyWithdraw(context: ActionContext<FundOperations, RootState>) {
        const { Master, Address } = context.getters;

        Master.methods
            .emergencyWithdraw()
            .send({ from: Address })
            .then(() => {
                context.dispatch('getBalance');
                context.dispatch('getTsunoBalance');
            })
            .catch((err: Error) => context.dispatch('setError', err));
    },
    deposit(
        context: ActionContext<FundOperations, RootState>,
        payload: Deposit
    ) {
        const { Master, Tsuno, Address } = context.getters;
        Tsuno.methods
            .allowance(Address, Master._address)
            .call({
                from: Address
            })
            .then((allowance: number) => {
                if (
                    new BN(allowance).isLessThan(
                        new BN(payload.amount).multipliedBy(10 ** 18)
                    )
                ) {
                    const modal = {
                        show: true,
                        content: 'allowance-form',
                        data: payload
                    };
                    context.dispatch('openModal', modal);
                    throw new Error(
                        "The amount is greater than the contract's allowance"
                    );
                }
                // TODO: replace 10 ** 18 with a DECIMAL constant
                const amountBN = new BN(payload.amount).multipliedBy(10 ** 18);
                return Master.methods
                    .deposit(amountBN, payload.length)
                    .send({ from: Address });
            })
            .then(() => {
                context.dispatch('getBalance');
                context.dispatch('getDateUnlocked');
                context.dispatch('getTsunoBalance');
            })
            .catch((err: Error) => context.dispatch('setError', err));
    }
};
