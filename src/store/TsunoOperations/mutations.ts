import { MutationTree } from 'vuex';
import { TsunoOperations } from '../types';

export const mutations: MutationTree<TsunoOperations> = {
    SET_TSUNO_BALANCE: (state: TsunoOperations, payload: any) =>
        (state.balance = payload)
};
