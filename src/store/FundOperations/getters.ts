import { GetterTree } from 'vuex';
import { RootState, FundOperations } from '../types';

export const getters: GetterTree<FundOperations, RootState> = {
    Balance: state => state.balance,
    StakedTime: state => state.stakedTime,
    DateUnlocked: state => state.dateUnlocked
};
