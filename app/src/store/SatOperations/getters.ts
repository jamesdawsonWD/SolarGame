import { GetterTree } from 'vuex';
import { RootState, SatOperations } from '../types';

export const getters: GetterTree<SatOperations, RootState> = {
    SAT_getBalances: state => (address: string) => state.balances[address],
    SAT_getBalance: (state, id: number) => state.balances[id],
    SAT_getTreasuryApproved: state => state.treasuryApproved
};
