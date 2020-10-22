import { MutationTree } from 'vuex';
import { SatOperations } from '../types';

export const mutations: MutationTree<SatOperations> = {
    SET_SAT_BALANCES: (state: SatOperations, payload: { balances: number[] }) => {
        state.balances = payload.balances;
    },
    SET_SAT_BALANCE: (state: SatOperations, payload: { id: number; balance: number }) => {
        state.balances[payload.id] = payload.balance;
    },
    SET_TREASURY_APPROVED: (state: SatOperations, payload: any) => (state.treasuryApproved = payload)
};
