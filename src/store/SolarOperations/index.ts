import { Module } from 'vuex';
import { RootState, SolarOperations } from '../types';
import { addressZero } from '@/utils';

export const state: SolarOperations = {
    balance: 0
};

import { getters } from './getters';
import { actions } from './actions';
import { mutations } from './mutations';

const namespaced = false;

export const solarOperations: Module<SolarOperations, RootState> = {
    namespaced,
    state,
    getters,
    mutations,
    actions
};
