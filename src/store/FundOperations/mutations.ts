import { MutationTree } from 'vuex';
import { FundOperations } from '../types';

export const mutations: MutationTree<FundOperations> = {
    SET_BALANCE: (state: FundOperations, payload: any) =>
        (state.balance = payload)
};
