import { RootState, Planets } from './../types';
import { Module } from 'vuex';

export const state: Planets = {
    tokenIdToProxy: {},
    planets: {}
};

import { getters } from './getters';
import { actions } from './actions';
import { mutations } from './mutations';

const namespaced = false;

export const planet: Module<Planets, RootState> = {
    namespaced,
    state,
    getters,
    mutations,
    actions
};
