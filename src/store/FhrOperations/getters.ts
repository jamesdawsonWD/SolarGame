import { GetterTree } from 'vuex';
import { RootState, FhrOperations } from '../types';

export const getters: GetterTree<FhrOperations, RootState> = {
    FHR_getBalance: state => state.balance,
    FHR_getTreasuryApproved: state => state.treasuryApproved,

};
