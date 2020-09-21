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
        console.log(unlocked);
        context.commit('SET_DATE_UNLOCKED', unlocked);
    },
    async deposit(
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
                console.log('ew', amountBN, allowance);
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
