import { MutationTree } from 'vuex';
import { SolarOperations } from '../types';

export const mutations: MutationTree<SolarOperations> = {
    SET_SOLAR_BALANCE: (state: SolarOperations, payload: any) => (state.balance = payload)
};
