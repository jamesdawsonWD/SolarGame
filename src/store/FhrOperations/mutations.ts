import { MutationTree } from 'vuex';
import { FhrOperations } from '../types';

export const mutations: MutationTree<FhrOperations> = {
    SET_FHR_BALANCE: (state: FhrOperations, payload: any) =>
        (state.balance = payload),
    SET_TREASURY_APPROVED: (state: FhrOperations, payload: any) =>
        (state.treasuryApproved = payload),
};
