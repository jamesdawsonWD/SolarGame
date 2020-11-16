import { ActionTree, ActionContext } from 'vuex';
import { RootState, TreasuryOperations } from '../types';
export const actions: ActionTree<TreasuryOperations, RootState> = {
    TREASURY_testMintSolar(
        context: ActionContext<TreasuryOperations, RootState>,
        payload: { to: string; amount: number }
    ) {
        const { Treasury, Address } = context.getters;
        console.log(Treasury, payload);
        Treasury.methods
            .testMintSolar(payload.to, payload.amount)
            .send({ from: Address })
            .then(() => {
                context.dispatch('SOLAR_retrieveBalance', { address: payload.to });
                context.dispatch('setSuccessMessage', `${payload.amount} successfully minted.`);
            })
            .catch((err: Error) => context.dispatch('setError', err));
    },
    TREASURY_testSendSats(
        context: ActionContext<TreasuryOperations, RootState>,
        payload: { ids: number[]; amounts: number[] }
    ) {
        const { Treasury, Address } = context.getters;
        Treasury.methods
            .testSendSats(Address, payload.ids, payload.amounts)
            .send({ from: Address })
            .then(() => {
                context.dispatch('SAT_getSatBalanceOfBatch', { ids: payload.ids, amounts: payload.amounts });
                context.dispatch('setSuccessMessage', `Sats successfully sent.`);
            })
            .catch((err: Error) => context.dispatch('setError', err));
    }
};
