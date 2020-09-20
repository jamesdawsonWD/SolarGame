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

    async deposit(
        context: ActionContext<FundOperations, RootState>,
        payload: Deposit
    ) {
        const { Master, Tsuno, Address } = context.getters;
        const allowance = await Tsuno.methods
            .allowance(Address, Master._address)
            .call({
                from: Address
            });
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
            return;
        }
        // TODO: replace 10 ** 18 with a DECIMAL constant
        const amountBN = new BN(payload.amount).multipliedBy(10 ** 18);
        console.log('ew', amountBN, allowance);
        await Master.methods
            .deposit(amountBN, payload.length)
            .send({ from: Address });
        context.dispatch('getBalance');
        context.dispatch('getTsunoBalance');
    }
};
