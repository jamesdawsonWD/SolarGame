import { ActionTree, ActionContext } from 'vuex';
import { RootState, SatOperations } from '../types';
export const actions: ActionTree<SatOperations, RootState> = {
    getSatBalanceOfBatch(
        context: ActionContext<SatOperations, RootState>,
        payload: { ids: number[]; address: string }
    ) {
        const { Sat, Address } = context.getters;
        const accounts = new Array(payload.ids.length).fill(Address);
        Sat.methods
            .balanceOfBatch(payload.ids, accounts)
            .call({ from: Address })
            .then((balances: number[]) => context.commit('SET_SAT_BALANCES', balances))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    getSatBalanceOf(
        context: ActionContext<SatOperations, RootState>,
        payload: { id: number; address: string }
    ) {
        const { Sat, Address } = context.getters;
        Sat.methods
            .balanceOf(payload.address, payload.id)
            .call({ from: Address })
            .then((balance: number) =>
                context.commit('SET_SAT_BALANCE', { balance, id: payload.id })
            )
            .catch((err: Error) => context.dispatch('setError', err));
    },
    getTreasuryApprovedForAllSats(context: ActionContext<SatOperations, RootState>) {
        const { Sat, Address, Treasury } = context.getters;
        Sat.methods
            .isApprovedForAll(Address, Treasury._address)
            .call({ from: Address })
            .then((result: boolean) => context.commit('SET_TREASURY_APPROVED', result))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    setTreasuryApprovalForAllSats(context: ActionContext<SatOperations, RootState>) {
        const { Sat, Address, Treasury } = context.getters;
        Sat.methods
            .setApprovalForAll(Treasury._address, true)
            .send({ from: Address })
            .then(() => context.dispatch('setSuccessMessage', 'SAT: Treasury approval successful.'))
            .catch((err: Error) => context.dispatch('setError', err));
    }
};
