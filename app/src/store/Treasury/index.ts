import { RootState, TreasuryOperations } from '../types';
import { Module } from 'vuex';

export const state: TreasuryOperations = {
    balances: {},
    treasuryApproved: false
};

import { getters } from './getters';
import { actions } from './actions';
import { mutations } from './mutations';

const namespaced = false;

export const treasuryOperations: Module<TreasuryOperations, RootState> = {
    namespaced,
    state,
    getters,
    mutations,
    actions
};
