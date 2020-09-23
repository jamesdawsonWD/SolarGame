import { Module } from 'vuex';
import { RootState, FundOperations } from '../types';

export const state: FundOperations = {
    balance: 0,
    stakedTime: 0,
    dateUnlocked: 0
};

import { getters } from './getters';
import { actions } from './actions';
import { mutations } from './mutations';

const namespaced = false;

export const fundOperations: Module<FundOperations, RootState> = {
    namespaced,
    state,
    getters,
    mutations,
    actions
};
