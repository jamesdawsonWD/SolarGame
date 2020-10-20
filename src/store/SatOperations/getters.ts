import { GetterTree } from 'vuex';
import { RootState, SatOperations } from '../types';

export const getters: GetterTree<SatOperations, RootState> = {
    SAT_getBalances: state => state.balances,
    SAT_getBalance: (state, id: number) => state.balances[id],
    SAT_getTreasuryApproved: state => state.treasuryApproved,
};
