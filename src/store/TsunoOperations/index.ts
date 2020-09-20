import { Module } from 'vuex';
import { RootState, TsunoOperations } from '../types';
import { addressZero } from '@/utils';

export const state: TsunoOperations = {
    balance: 0
};

import { getters } from './getters';
import { actions } from './actions';
import { mutations } from './mutations';

const namespaced = false;

export const tsunoOperations: Module<TsunoOperations, RootState> = {
    namespaced,
    state,
    getters,
    mutations,
    actions
};
