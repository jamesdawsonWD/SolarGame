import { Module } from 'vuex';
import { RootState, FhrOperations } from '../types';
import { addressZero } from '@/utils';

export const state: FhrOperations = {
    balance: [],
    treasuryApproved: false
};

import { getters } from './getters';
import { actions } from './actions';
import { mutations } from './mutations';

const namespaced = false;

export const fhrOperations: Module<FhrOperations, RootState> = {
    namespaced,
    state,
    getters,
    mutations,
    actions
};
