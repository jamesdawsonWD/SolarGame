import { GetterTree } from 'vuex';
import { RootState, TsunoOperations } from '../types';

export const getters: GetterTree<TsunoOperations, RootState> = {
    TsunoBalance: state => state.balance
};
