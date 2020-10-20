import { GetterTree } from 'vuex';
import { RootState, SolarOperations } from '../types';

export const getters: GetterTree<SolarOperations, RootState> = {
    Solar_getBalance: state => state.balance
};
