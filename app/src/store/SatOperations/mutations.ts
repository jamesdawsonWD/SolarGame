import { MutationTree } from 'vuex';
import { SatOperations } from '../types';

export const mutations: MutationTree<SatOperations> = {
    SET_SAT_BALANCES: (state: SatOperations, payload: { balances: number[]; address: string }) => {
        state.balances = {
            ...state.balances,
            ...{ [payload.address]: payload.balances }
        };
    },
    SET_SAT_BALANCE: (state: SatOperations, payload: { id: number; balance: number; address: string }) => {
        const newBalances = state.balances[payload.id];
        newBalances[payload.id] = payload.balance;
        state.balances = {
            ...state.balances,
            ...{
                [payload.address]: newBalances
            }
        };
    },
    SET_TREASURY_APPROVED: (state: SatOperations, payload: any) => (state.treasuryApproved = payload)
};
