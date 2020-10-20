import { ActionTree, ActionContext } from 'vuex';
import { RootState, FhrOperations } from '../types';
export const actions: ActionTree<FhrOperations, RootState> = {
    getFhrBalance(context: ActionContext<FhrOperations, RootState>) {
        const { Fhr, Address } = context.getters;
        Fhr.methods
            .balanceOf(Address)
            .call({ from: Address })
            .then((balance: number) => {
                const getTokensP = [];
                for (let i = 0; i < balance; i++) {
                    getTokensP.push(Fhr.methods.tokenOfOwnerByIndex(i).call({ from: Address }))
                }
                return Promise.all(getTokensP);
            })
            .then((tokenIds: number[]) => context.commit('SET_FHR_BALANCE', tokenIds))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    getTreasuryApprovedForAll(context: ActionContext<FhrOperations, RootState>) {
        const { Fhr, Address, Treasury } = context.getters;
        Fhr.methods
            .isApprovedForAll(Address, Treasury._address)
            .call({ from: Address })
            .then((result: boolean) => context.commit('SET_TREASURY_APPROVED', result))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    setTreasuryApprovalForAll(
        context: ActionContext<FhrOperations, RootState>
    ) {
        const { Fhr, Address, Treasury } = context.getters;
        Fhr.methods
            .setApprovalForAll(Treasury._address, true)
            .send({ from: Address })
            .then(() => context.dispatch('setSuccessMessage', 'FHR: Treasury approval successful.'))
            .catch((err: Error) => context.dispatch('setError', err));
    }
};
