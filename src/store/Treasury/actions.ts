import { ActionTree, ActionContext } from 'vuex';
import { RootState, TreasuryOperations } from '../types';
export const actions: ActionTree<TreasuryOperations, RootState> = {
    testMintSolar(context: ActionContext<TreasuryOperations, RootState>, payload: { to: string, amount: number }) {
        const { Treasury, Address } = context.getters;
        Treasury.methods
            .testMintSolar(payload.to, payload.amount)
            .call({ from: Address })
            .then(() => context.dispatch('setSuccessMessage', `${payload.amount} successfully minted.`))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    testSendSats(context: ActionContext<TreasuryOperations, RootState>, payload: { ids: number[], amounts: number[] }) {
        const { Treasury, Address } = context.getters;
        Treasury.methods
            .testSendSats(Address, payload.ids, payload.amounts)
            .call({ from: Address })
            .then(() => context.dispatch('setSuccessMessage', `Sats successfully sent.`))
            .catch((err: Error) => context.dispatch('setError', err));
    },

};
