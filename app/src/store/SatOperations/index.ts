import { RootState, SatOperations } from '../types';
import { Module } from 'vuex';

export const state: SatOperations = {
    balances: {},
    treasuryApproved: false
};

import { getters } from './getters';
import { actions } from './actions';
import { mutations } from './mutations';

const namespaced = false;

export const satOperations: Module<SatOperations, RootState> = {
    namespaced,
    state,
    getters,
    mutations,
    actions
};
